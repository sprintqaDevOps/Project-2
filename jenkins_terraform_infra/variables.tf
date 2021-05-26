variable "key_name" {
  type = string
  sensitive = true
}

variable "ssh_key_path" {
  type = string
  sensitive = true
}

variable "region" {
  type = string
}

variable "prefix" {
  type = string
}

variable "ami" {
  type = map(string)
  default = {
    "us-east-1" = "ami-038f1ca1bd58a5790"
    "us-east-2" = "ami-07a0844029df33d7d"
    "us-west-1" = "ami-0c7945b4c95c0481c"
  }
}
variable "instance_type" {
  type = string
}

variable "map_public_ip_on_launch" {
  type = string
}

variable "domain" {}
variable "record" {}