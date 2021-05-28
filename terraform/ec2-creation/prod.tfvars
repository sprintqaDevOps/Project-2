ssh_key_path = "~/.ssh/id_rsa.pub"
key_name = "developer-key"
ami = "ami-0d5eff06f840b45e9"
instance_type = "t2.medium"
security_group_name = "allow-ssh-http"
region = "us-east-1"
user_data = <<-EOF
    #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo docker run -d -p 8095:80 dzhovid/train-schedule:v3
  EOF

ssh-port = "22"
http-port = "80"
https-port = "443"
jenkins-port = "8095"
cidr_blocks = ["0.0.0.0/0"]
prefix = "PROD"
