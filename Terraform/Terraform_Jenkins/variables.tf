variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2_tags" {
  type = map(any)
  default = {
    Name = "Jenkins EC2"
  }
}

variable "key" {
  description = "Ec2 Key"
  type        = string
  default     = "terraform_key"
}

variable "az" {
  description = "Availability zone"
  type = string
  default = "us-east-1a"
}