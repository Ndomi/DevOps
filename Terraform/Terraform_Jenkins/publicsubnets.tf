resource "aws_subnet" "public_sn" {
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = var.vpc_cidr
  availability_zone = var.az
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Jenkins Public Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "Jenkins IGW"
  }
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.jenkins_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "Jenkins RT"
  }
}

resource "aws_route_table_association" "pub_subnet_association" {
  subnet_id = aws_subnet.public_sn.id
  route_table_id = aws_route_table.publicRT.id
}