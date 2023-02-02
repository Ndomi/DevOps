resource "aws_nat_gateway" "nat_gw" {
  count         = var.availability_zones_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.EIP.*.id, count.index)

  depends_on = [
    aws_eip.EIP,
    aws_subnet.private
  ]

  tags = {
    Name = "Nat Gateway"
  }
}
