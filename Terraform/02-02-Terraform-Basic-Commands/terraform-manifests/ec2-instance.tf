# Terraform Setting Block
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        #version = "~>3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal
  region = "us-east-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
}