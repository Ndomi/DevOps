locals {
  ec2_ami               = data.aws_ami.amzlinux2.id
  ec2_instance_type     = "t2.small"
  alb_security_group_id = module.alb_sg.security_group_id
}

# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = [ "amzn2-ami-hvm-*-gp2" ]
    }

    filter {
      name = "root-device-type"
      values = [ "ebs" ]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }

    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }
  
}

module "instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.prefix}-nginx-sg"
  description = "Security group for nginx web servers"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]
}

resource "aws_instance" "nginx" {
  count                       = length(module.vpc.private_subnets)
  ami                         = local.ec2_ami
  instance_type               = local.ec2_instance_type
  vpc_security_group_ids      = [module.instance_sg.security_group_id]
  subnet_id                   = module.vpc.private_subnets[count.index]
  associate_public_ip_address = true

  user_data = <<EOT
#!/bin/bash
apt update -y
apt install nginx -y
systemctl enable nginx
  EOT

  tags = merge(
    {
      Name = "${local.prefix}-nginx-${count.index + 1}"
    },
    local.common_tags
  )
}