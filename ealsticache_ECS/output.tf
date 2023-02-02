output "redis_sg" {
  value = aws_security_group.sg_redis.id
}

#output "primary_endpoint_address" {
#  value = aws_elasticache_replication_group.redis.*.primary_endpoint_address
#}
#
#output "configuration_endpoint_address" {
#  value = aws_elasticache_replication_group.redis.*.configuration_endpoint_address
#}

output "alb_hostname" {
  value = aws_alb.ecs_alb.name
}

output "alb_name" {
  value = aws_alb.ecs_alb.dns_name
}

output "private_1" {
  value = aws_subnet.private.*.id
}