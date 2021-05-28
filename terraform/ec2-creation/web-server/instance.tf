resource "aws_instance" "dev" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  #subnet_id     = var.subnet_id

  vpc_security_group_ids      = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true 

  user_data = var.user_data

  tags = {
    Name = "DEV_server"
  }
}

