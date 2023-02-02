resource "aws_eip" "EIP" {
  count = var.availability_zones_count
  vpc   = true
  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    "Name" = "EIP"
  }
}