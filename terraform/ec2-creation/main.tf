provider "aws" {
  region = var.region
}

# module "myapp-vpc" {
#     source = "./vpc"

#     cidr_block_vpc    = var.cidr_block_vpc
#     prefix            = var.prefix
#     cidr_block_subnet = var.cidr_block_subnet
#     cidr_block_route  = var.cidr_block_route
# }

resource "aws_default_vpc" "my_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

module "myapp-webserver" {
    source = "./web-server"

    key_name            = var.key_name
    ssh_key_path        = var.ssh_key_path
    ami                 = var.ami
    instance_type       = var.instance_type
    #subnet_id           = module.myapp-vpc.subnet.id
    vpc_id              = aws_default_vpc.my_vpc.id
    #prefix              = var.prefix
    security_group_name = var.security_group_name

    # depends_on = [
    #   module.myapp-vpc
    # ]
    
}