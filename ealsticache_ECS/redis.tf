resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "${var.project_redis}-${var.environment}-${var.name}"
  engine                     = "redis"
  engine_version             = var.engine_version
  port                       = var.port
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_nodes
  parameter_group_name       = var.parameter_group_name
  security_group_ids         = [aws_security_group.sg_redis.id]
  subnet_group_name          = aws_elasticache_subnet_group.elasticache.id
  availability_zones         = [var.az_1, var.az_2]
  automatic_failover_enabled = var.automatic_failover_enabled
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  multi_az_enabled           = var.multi_az_enabled
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  description                = "Redis cluster for ${var.project_redis}-${var.environment}-${var.name}"

  tags = {
    Name        = "${var.project_redis}-${var.environment}-${var.name}-replication_group"
    Environment = var.environment
  }
}

resource "aws_elasticache_subnet_group" "elasticache" {
  #  count = var.availability_zones_count

  name        = "${var.project_redis}-${var.environment}-redis"
  description = "Our main group of subnets"
  subnet_ids  = [aws_subnet.private[0].id, aws_subnet.private[1].id]
}
