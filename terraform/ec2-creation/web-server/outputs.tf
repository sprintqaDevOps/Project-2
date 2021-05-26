output "ip_address" {
    value = [aws_instance.dev.public_ip,aws_instance.qa.public_ip,aws_instance.prod.public_ip]
}