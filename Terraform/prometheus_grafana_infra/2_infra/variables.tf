variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_cidr" {
  description = "Please eneter cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "Please choose instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_tags" {
  type = map(any)
  default = {
    Name = "Prom Graf"
  }
}

variable "key" {
  description = "Add key"
  type        = string
  default     = "New_Key_Ireland"
}