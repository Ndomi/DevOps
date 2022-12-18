resource "aws_instance" "jenkins" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_sn.id
  user_data = file("${path.module}/jenkins.sh")
  key_name = var.key
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
}