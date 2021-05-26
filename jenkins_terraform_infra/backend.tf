terraform {
  backend "s3" {
    bucket  = "teamhulk-tfstate-backend-bucket"
    key     = "tfstate/backend.tfstate"
    region  = "us-east-1"
    profile = "teamhulk"
  }
}