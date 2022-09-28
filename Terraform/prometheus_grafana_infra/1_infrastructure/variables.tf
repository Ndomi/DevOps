variable "prefix" {
  default = "managing-alb-using-terraform"
  description = "Common prefix for AWS resources names"
}

variable "aws_region" {
  default = "eu-west-1"
  description = "AWS Region to deploy VPC"
}