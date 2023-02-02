resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/app"
  retention_in_days = 30

  tags = {
    Name = "log-group"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  log_group_name = aws_cloudwatch_log_group.log_group.name
  name           = "log-stream"
}