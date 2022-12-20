resource "aws_subnet" "my_subnet" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.myvpc.id

  availability_zone = var.az
  map_public_ip_on_launch = true
  
  tags = {
    "Name" = "My Subnet"
  }
}