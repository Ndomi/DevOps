terraform {
  /* required_version = "~> 1.2" */
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }

   # Adding Backend as S3 for Remote State Storage with Locking
  backend "s3" {
    bucket = "prom-graf-bucket"
    key    = "devops/terraform.tfstate"
    region = "eu-west-1"
    profile = "devops"

  dynamodb_table = "prom-graf-state-table"
  }
}

provider "aws" {
  region = var.aws_region
  profile = "devops"
}