resource "aws_vpc" "my_vpc" {

  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jenkins-vpc"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.100.2.0/24"
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.prefix}-Jenkins-public"
  }
}


resource "aws_route_table" "r" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.prefix}-route_table"
  }
}

resource "aws_route_table_association" "route_associate" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.r.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_security_group" "ec2" {
  name = "jenkins"
  vpc_id      = aws_vpc.my_vpc.id

 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8095
    to_port     = 8095
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8096
    to_port     = 8096
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8097
    to_port     = 8097
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

