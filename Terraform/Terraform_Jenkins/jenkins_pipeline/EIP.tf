resource "aws_eip" "eip" {
  vpc = true

  tags = {
    "Name" = "${var.project}-ngw-ip"
  }
}