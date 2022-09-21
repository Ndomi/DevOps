resource "aws_route_table" "custom_RT" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block = var.internet_ip
      gateway_id = aws_internet_gateway.EKS_IGW.id
  }

  tags = {
      Name = "Prom Graf RT"
  }

  depends_on = [aws_vpc.eks_vpc, aws_internet_gateway.EKS_IGW]
}