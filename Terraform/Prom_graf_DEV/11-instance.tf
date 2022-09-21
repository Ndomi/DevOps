resource "aws_instance" "prograf" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.EKS_Subnet.id
  key_name = var.key
  monitoring = true
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.web-traffic.id ]

  tags = {
    "Name" = "Prom Graf"
  }
}