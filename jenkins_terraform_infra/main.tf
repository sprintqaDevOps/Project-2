terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = "teamhulk"
}

data "aws_route53_zone" "zone" {
  name         = var.domain
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "${var.record}.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]

  depends_on = [
    aws_instance.web
  ]
}

resource "aws_instance" "web" {
  ami                    = var.ami[var.region]
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_name
  user_data              = <<-EOF
                 #!/bin/bash
                  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
                  sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
                  sudo yum upgrade
                  sudo yum install jenkins java-1.8.0-openjdk-devel -y
                  sudo systemctl daemon-reload
                  sudo systemctl start jenkins
                  sudo systemctl enable jenkins
                  sudo amazon-linux-extras install docker -y
                  sudo yum install docker -y
                  sudo service docker start
                  sudo usermod -a -G docker ec2-user
                  sudo chmod 666 /var/run/docker.sock
                  sudo yum install git -y
                  sudo usermod -a -G docker ec2-user
                  sudo usermod -a -G docker jenkins
                  sudo usermod -a -G wheel jenkins
                  sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
                  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                  unzip awscliv2.zip
                  sudo ./aws/install
                  # TERRAFORM_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
                  wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip
                  sudo yum -y install unzip
                  unzip terraform_0.15.3_linux_amd64.zip
                  sudo mv terraform /usr/bin/
                  ssh-keygen -q -t rsa -N '' <<< ""$'\n'"y" 2>&1 >/dev/null
                  sudo cp /var/lib/jenkins/secrets/initialAdminPassword ~/pass.txt

              EOF

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Name = "Root Volume"
    }
  }

  tags = {
    Name = "${var.prefix}-Jenkins"
  }

}

resource "aws_key_pair" "my_jenkins_key" {
  key_name   = var.key_name
  public_key = file(var.ssh_key_path)
}

output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}

output "jenkins_website" {
  value = "${aws_route53_record.jenkins.name}:8080"
}

