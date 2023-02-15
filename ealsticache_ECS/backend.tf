resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name" = "Terraform Lock Table"
  }
}

terraform {
  required_version = "~> 1.3.7"
  backend "s3" {
    bucket = "redis-ecs-20230202"
    region = "us-east-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}