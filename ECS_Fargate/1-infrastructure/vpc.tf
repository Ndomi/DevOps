provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

resource "aws_vpc" "production_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

resource "aws_subnet" "production_public_subnet_one" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.public_subnet_1
  availability_zone = var.az_1

  tags = {
    Name = "Production_Public_Subnet_One"
  }
}

resource "aws_subnet" "production_public_subnet_two" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.public_subnet_2
  availability_zone = var.az_2

  tags = {
    Name = "Production_Public_Subnet_Two"
  }
}

resource "aws_subnet" "production_public_subnet_three" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.public_subnet_3
  availability_zone = var.az_3

  tags = {
    Name = "Production_Public_Subnet_Three"
  }
}

resource "aws_subnet" "production_private_subnet_one" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.az_1

  tags = {
    Name = "Production_Private_Subnet_One"
  }
}

resource "aws_subnet" "production_private_subnet_two" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.az_2

  tags = {
    Name = "Production_Private_Subnet_Two"
  }
}

resource "aws_subnet" "production_private_subnet_three" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.private_subnet_3
  availability_zone = var.az_3

  tags = {
    Name = "Production_Private_Subnet_Three"
  }
}

resource "aws_route_table" "production_public_RT" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production Public Route Table"
  }
}

resource "aws_route_table" "production_private_RT" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production Private Route Table"
  }
}

resource "aws_route_table_association" "production_public_RT_1_assoc" {
  route_table_id = aws_route_table.production_public_RT.id
  subnet_id      = aws_subnet.production_public_subnet_one.id
}

resource "aws_route_table_association" "production_public_RT_2_assoc" {
  route_table_id = aws_route_table.production_public_RT.id
  subnet_id      = aws_subnet.production_public_subnet_two.id
}

resource "aws_route_table_association" "production_public_RT_3_assoc" {
  route_table_id = aws_route_table.production_public_RT.id
  subnet_id      = aws_subnet.production_public_subnet_three.id
}

resource "aws_route_table_association" "production_private_RT_1_assoc" {
  route_table_id = aws_route_table.production_private_RT.id
  subnet_id      = aws_subnet.production_private_subnet_one.id
}

resource "aws_route_table_association" "production_private_RT_2_assoc" {
  route_table_id = aws_route_table.production_private_RT.id
  subnet_id      = aws_subnet.production_private_subnet_two.id
}

resource "aws_route_table_association" "production_private_RT_3_assoc" {
  route_table_id = aws_route_table.production_private_RT.id
  subnet_id      = aws_subnet.production_private_subnet_three.id
}

resource "aws_eip" "elastic_ip_for_nat_gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"

  tags = {
    Name = "Production EIP"
  }
}

resource "aws_nat_gateway" "production_nat_gw" {
  subnet_id     = aws_subnet.production_public_subnet_one.id
  allocation_id = aws_eip.elastic_ip_for_nat_gw.id

  tags = {
    Name = "Production NAT Gateway"
  }

  depends_on = [
    aws_eip.elastic_ip_for_nat_gw,
    aws_subnet.production_private_subnet_one
  ]
}

resource "aws_route" "production_nat_gw_route" {
  route_table_id         = aws_route_table.production_private_RT.id
  nat_gateway_id         = aws_nat_gateway.production_nat_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "production_igw" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production IGW"
  }
}

resource "aws_route" "production_public_internet_gw_route" {
  route_table_id         = aws_route_table.production_public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.production_igw.id
}