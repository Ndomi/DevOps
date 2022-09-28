# ------------ Create AWS ALB Security Group -----------

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.prefix}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
}

# ------------ Create AWS ALB -----------

resource "aws_lb" "web" {
  name            = "${local.prefix}-alb"
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_sg.security_group_id]

  tags = merge(
    {
      Name = "${local.prefix}-alb"
    },
    local.common_tags
  )
}

locals {
  resource_name             = trimsuffix(substr("${local.prefix}-ip-tg", 0, 32), "-")
  alb_arn                   = aws_lb.web.arn
  alb_sg                    = module.alb_sg.security_group_id
}

resource "aws_lb_target_group" "web" {
  name     = local.resource_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = merge(
    {
      Name = local.resource_name
    },
    local.common_tags
  )
}

module "web_http_sg" {
  source = "terraform-aws-modules/security-group/aws"

  create_sg           = false
  security_group_id   = module.alb_sg.security_group_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["http-80-tcp"]
}

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count            = length(aws_instance.nginx)
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.nginx[count.index].private_ip
  port             = 80
}