output "aws_grafana_workspace_value" {
  value     = aws_grafana_workspace.my_workspace.id
  sensitive = true
}