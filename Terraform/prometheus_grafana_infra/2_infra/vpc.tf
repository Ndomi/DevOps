resource "aws_vpc" "prom_graf" {
  provider             = aws.region
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "prom graf"
  }
}