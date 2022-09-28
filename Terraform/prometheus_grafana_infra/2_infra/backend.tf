terraform {
  required_version = ">=0.13.0"
  backend "s3" {
    region         = "eu-west-1"
    profile        = "default"
    key            = "terraformstatefile.tfstate"
    bucket         = "prom-graf1013"
    dynamodb_table = "my_graf_dynamodb"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}