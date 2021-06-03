resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file("~/.ssh/id_rsa.pub")
  lifecycle {
    ignore_changes = [public_key]
  }
}