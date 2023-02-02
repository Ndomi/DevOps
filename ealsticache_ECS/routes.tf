resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.ecs-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
  count  = var.availability_zones_count
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }

  tags = {
    "Name" = "Private_RT"
  }
}