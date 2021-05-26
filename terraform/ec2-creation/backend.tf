terraform {
  backend "s3" {
    bucket = "terraform-state-file-asel"
    key    = "tfstate/sample-module8.tfstate"
    region = "us-east-1"
  }
}