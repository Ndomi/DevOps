variable "instance_type" {
  description = "Instance Type"
  type = string
  default = "t3.micro"
}

variable "aws_region" {
  description = "Default region"
  type = string
  default = "eu-west-1"
}

variable "key" {
  description = "Add key"
  type = string
  default = "eks_key"
}

variable "vpc_cidr" {
    description = "VPC Cidr"
    type = string
    default = "10.2.0.0/26"
}

variable "subnet_cidr" {
  description = "Subnet Cidr"
  type = string
  default = "10.2.0.0/28"
}

variable "az" {
  description = "Availability zone"
  type = string
  default = "eu-west-1a"
}

variable "internet_ip" {
  description = "Internet IP"
  type = string
  default = "0.0.0.0/0"
}