resource "aws_route_table" "my_RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "${var.project}-RT"
  }
}

resource "aws_route_table_association" "internet_access" {
  count = var.availability_zones_count

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.my_RT.id
}