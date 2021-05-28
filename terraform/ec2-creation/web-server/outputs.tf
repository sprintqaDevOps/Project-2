output "ip_address" {
    value = [aws_instance.dev.public_ip]
}