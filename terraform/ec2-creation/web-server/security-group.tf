resource "aws_security_group" "allow_ssh_http" {
  name        = var.security_group_name
  vpc_id      = var.vpc_id


  ingress {
    description = "Ssh from VPC"
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
ingress {
    description = "Http from VPC"
    from_port   = var.http-port
    to_port     = var.http-port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  ingress {
    description = "Local jenkins"
    from_port   = var.jenkins-port
    to_port     = var.jenkins-port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  ingress {
    description = "Https"
    from_port   = var.https-port
    to_port     = var.https-port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  tags = {
    Name = "allow_ssh_http"
  }
}