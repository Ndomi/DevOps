resource "aws_subnet" "private" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.ecs-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.ecs-vpc.cidr_block, 3, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project}-private-sg"
  }
}

resource "aws_subnet" "public" {
  count = var.availability_zones_count

  cidr_block = cidrsubnet(aws_vpc.ecs-vpc.cidr_block, 3, count.index + var.availability_zones_count)
  vpc_id     = aws_vpc.ecs-vpc.id

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.project}-public-sg"
  }
}