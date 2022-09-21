resource "aws_internet_gateway" "EKS_IGW" {
  vpc_id = aws_vpc.eks_vpc.id
  depends_on = [
    aws_vpc.eks_vpc
  ]
}