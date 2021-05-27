terraform {
  backend "s3" {
    bucket  = "teamhulk-tfstate-backend-bucket"
    key     = "tfstate/ec2-new.tfstate"
    region  = "us-east-1"
  }
}