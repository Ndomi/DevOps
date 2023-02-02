resource "aws_alb" "ecs_alb" {
  name = "load-balancer"
  subnets = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
  internal = false

  tags = {
    Name = "ALB"
  }
}

resource "aws_alb_target_group" "app" {
  name = "target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.ecs-vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.ecs_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = aws_acm_certificate.ecs_domain_certificate.arn

  default_action {
    target_group_arn = aws_alb_target_group.app.arn
    type             = "forward"
  }

  depends_on = [
    aws_alb_target_group.app
  ]
}

resource "aws_route53_record" "ecs_loadbalance_record" {
  name = "*.${var.ecs_domain_name}"
  type = "A"
  zone_id = data.aws_route53_zone.ecs_domain.zone_id

  alias {
    evaluate_target_health = false
    name = aws_alb.ecs_alb.dns_name
    zone_id = aws_alb.ecs_alb.zone_id
  }
}

resource "aws_iam_role" "ecs_cluster_role" {
  name               = "${var.ecs_cluster_name}-IAM-ROLE"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
  "Effect": "Allow",
  "Principal": {
    "Service": ["ecs.amazonaws.com", "ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
  },
  "Action": "sts:AssumeRole"
  }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
  name = "${var.ecs_cluster_name}-IAM-Role"
  role = aws_iam_role.ecs_cluster_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:*",
        "ec2:*",
        "elasticloadbalancing:*",
        "ecr:*",
        "dynamodb:*",
        "cloudwatch:*",
        "s3:*",
        "rds:*",
        "sqs:*",
        "sns:*",
        "logs:*",
        "ssm:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}