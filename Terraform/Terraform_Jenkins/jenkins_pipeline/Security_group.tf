resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow SSH traffic Inbound"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //Don't do this. Not secure
  }

  egress {
    description = "Allow outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Allow SSH Traffic"
  }

}