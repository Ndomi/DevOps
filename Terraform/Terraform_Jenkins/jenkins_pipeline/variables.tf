variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "profile" {
  type = string
  default = "default"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}