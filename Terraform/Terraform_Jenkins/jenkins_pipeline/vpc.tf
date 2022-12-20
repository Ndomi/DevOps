resource "aws_vpc" "vpc_id" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "${var.project}-vpc"
    "kubernetes.io/cluster/${var.project}-cluster" = "shared"
  }
}