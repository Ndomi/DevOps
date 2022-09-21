resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.elastic_IP.id
  subnet_id = aws_subnet.EKS_Subnet.id

  tags = {
      Name = "Prom Graf natgateway"
  }

  depends_on = [aws_vpc.eks_vpc, aws_eip.elastic_IP]
}