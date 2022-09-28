resource "aws_subnet" "private_sn" {
  count             = length(slice(local.az_names, 0, 2))
  vpc_id            = aws_vpc.prom_graf.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 2, count.index + length(slice(local.az_names, 0, 2)))
  availability_zone = local.az_names[count.index]
  tags = {
    Name = "PrivateSubnet-{count.index + 1}"
  }
}

resource "aws_eip" "EIP" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  #  count         = length(slice(local.az_names, 0, 2))
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.public_sn.*.id[0]

  tags = {
    Name = "NatGateway"
  }
}

output "nat_gateway_ip" {
  value = aws_eip.EIP.public_ip
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.prom_graf.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "mydemoprivatert"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(slice(local.az_names, 0, 2))
  subnet_id      = aws_subnet.private_sn.*.id[count.index]
  route_table_id = aws_route_table.privatert.id
}