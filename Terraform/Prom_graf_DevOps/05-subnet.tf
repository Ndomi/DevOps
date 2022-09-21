resource "aws_subnet" "EKS_Subnet" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.eks_vpc.id

  availability_zone = var.az
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Prom Graf Subnet"
  }
}