resource "aws_security_group" "app-test" {
  vpc_id      = aws_vpc.main.id
  name        = "application - production"
  description = "security group for my app"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myinstance"
  }
}

resource "aws_security_group" "docker" {
  vpc_id      = aws_vpc.main.id
  name        = "docker"
  description = "docker"
  ingress {
    from_port       = 8095
    to_port         = 8095
    protocol        = "tcp"
    security_groups = [aws_security_group.app-test.id] # allowing access from our example instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "docker"
  }
}