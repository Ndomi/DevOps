resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    "Name" = "${var.project}-igw"
  }

  depends_on = [
    aws_vpc.myvpc
  ]
}