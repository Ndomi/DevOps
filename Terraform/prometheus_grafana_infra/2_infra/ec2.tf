locals {
  env_tag = {
    Environment = terraform.workspace
  }
  tags = merge(var.ec2_tags, local.env_tag)
}

resource "aws_instance" "web" {
  count         = 1
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_sn.*.id[count.index]
  tags          = var.ec2_tags
  user_data     = file("${path.module}/apache.sh")
  key_name      = var.key
  /* iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name */
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}