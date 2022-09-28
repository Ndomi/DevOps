output "prefix" {
  value       = local.prefix
  description = "Exported common resources prefix"
}

output "common_tags" {
  value       = local.common_tags
  description = "Exported common resources tags"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "VPC public subnets' IDs list"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "VPC private subnets' IDs list"
}

output "alb_security_group_id" {
  value = module.alb_sg.security_group_id
}

output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

output "alb_arn" {
  value = aws_lb.web.arn
}

output "alb_dns_zone_id" {
  value = aws_lb.web.zone_id
}