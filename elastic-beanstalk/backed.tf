terraform {
  backend "s3" {
    bucket  = "teamhulk-tfstate-backend-bucket"
    key     = "tfstate/eb-backend.tfstate"
    region  = "us-east-1"
  }
}