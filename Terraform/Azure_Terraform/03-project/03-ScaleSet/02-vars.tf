variable "location" {
  type = string
  default = "westeurope"
}

variable "prefix" {
  type = string
  default = "demo"
}

variable "zones" {
  type = list(string)
  default = []
}

variable "ssh-source-address" {
  type = string
  default = "*"
}