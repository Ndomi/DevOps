resource "aws_security_group" "ec2_sg" {
  name = "ec2-sg"
  description = "Allow inbound traffic for web application on ec2"
  vpc_id = aws_vpc.jenkins_vpc.id

  ingress {
    description = "Web Port"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "SSH Port"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "102.65.69.45/32" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    "Name" = "Jenkins EC2 SG"
  }
}