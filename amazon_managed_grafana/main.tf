resource "aws_grafana_workspace" "my_workspace" {
  name                     = "my-grafana"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = aws_iam_role.assume.arn
  data_sources             = [
                              "CLOUDWATCH",
                              "XRAY",
                              "PROMETHEUS"
                             ]
}

resource "aws_iam_role" "assume" {
  name = "tf-grafana-assume"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "gf_cw_policy_role" {
  name       = "cloudwatch_attachment"
  roles      = [aws_iam_role.assume.name]
  policy_arn = aws_iam_policy.grafana_cw_policy.arn
}

resource "aws_grafana_role_association" "role" {
  role         = "ADMIN"
  workspace_id = aws_grafana_workspace.my_workspace.id
  user_ids = [
    "f4e884e8-90b1-70a3-7d39-b769e5a83093"
  ]
}