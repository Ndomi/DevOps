variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet_1" {
  #  default = "10.0.1.0/24"
  description = "Public Subnet One"
}

variable "public_subnet_2" {
  #  default = "10.0.2.0/24"
  description = "Public Subnet Two"
}

variable "public_subnet_3" {
  #  default = "10.0.3.0/24"
  description = "Public Subnet Three"
}

variable "private_subnet_1" {
  #  default = "10.0.1.0/24"
  description = "Private Subnet One"
}

variable "private_subnet_2" {
  #  default = "10.0.2.0/24"
  description = "Private Subnet Two"
}

variable "private_subnet_3" {
  #  default = "10.0.3.0/24"
  description = "Private Subnet Three"
}

variable "az_1" {
  default     = "us-east-1a"
  description = "Production AZ One"
}

variable "az_2" {
  default     = "us-east-1b"
  description = "Production AZ Two"
}

variable "az_3" {
  default     = "us-east-1c"
  description = "Production AZ Three"
}
