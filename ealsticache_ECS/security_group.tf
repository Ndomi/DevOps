resource "aws_security_group" "lb" {
  name        = "load-balancer-security-group"
  description = "controls access to the security ALB"
  vpc_id      = aws_vpc.ecs-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.ecs-vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECS Task Security Group"
  }
}

resource "aws_security_group" "sg_redis" {
  name        = "sg_${var.name}_${var.project}_${var.environment}"
  description = "Security group that is needed for the ${var.name} servers"
  vpc_id      = aws_vpc.ecs-vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-${var.name}-redis_sg"
  }
}

resource "aws_security_group_rule" "sg_app_to_redis" {
  from_port                = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_redis.id
  to_port                  = var.port
  type                     = "ingress"
  source_security_group_id = aws_security_group.allowed_sg.id
}

resource "aws_security_group" "allowed_sg" {
  name   = "${var.name}_${var.project}_${var.environment}-allowed_sg"
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-${var.name}-allowed_sg"
  }
}

resource "aws_security_group_rule" "allowed_sg" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.allowed_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}