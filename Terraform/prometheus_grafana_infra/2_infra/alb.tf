# Create Target group

resource "aws_lb_target_group" "myapp" {
  name     = "myapp-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prom_graf.id
}

# Attach EC2 instances to traget group

resource "aws_lb_target_group_attachment" "myapp" {
  count            = 1
  target_group_arn = aws_lb_target_group.myapp.arn
  target_id        = aws_instance.web.*.id[count.index]
  port             = 80
}

# Create ALB

resource "aws_lb" "myapp" {
  name               = "myapp-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_sn.*.id

  enable_deletion_protection = false

  tags = {
    Environment = terraform.workspace
  }
}

# Configure ALB Listerner

resource "aws_lb_listener" "myapp" {
  load_balancer_arn = aws_lb.myapp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myapp.arn
  }
}

resource "aws_lb_listener" "myapp_1" {
  load_balancer_arn = aws_lb.myapp.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myapp.arn
  }
}

/* resource "aws_lb_listener" "internal_alb_https" {
  load_balancer_arn = aws_lb.myapp.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "arn:aws:acm:eu-west-1:225908212644:certificate/c9a4563f-66c4-4da9-ab6c-97b950e1a9e4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myapp.arn
  }
} */

/* resource "aws_route53_record" "node" {
  zone_id = "Z03668682XN7JRA5N56KE"
  name    = "preseasongames.net"
  type    = "A"
  alias {
    name                   = aws_lb.myapp.dns_name
    zone_id                = aws_lb.myapp.zone_id
    evaluate_target_health = true
  }
} */