resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow inbound traffic for web applicaiton on ec2"
  vpc_id      = aws_vpc.prom_graf.id

  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prom_graf.cidr_block]
  }
  ingress {
    description = "ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prom_graf.cidr_block, "0.0.0.0/0"]
  }

  ingress {
    description = "grafana port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prom_graf.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}