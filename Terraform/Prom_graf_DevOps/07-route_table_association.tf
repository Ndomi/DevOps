resource "aws_route_table_association" "EKS_RT_association" {
  route_table_id = aws_route_table.custom_RT.id
  subnet_id = aws_subnet.EKS_Subnet.id
  depends_on = [
    aws_subnet.EKS_Subnet,
    aws_route_table.custom_RT
  ]
}