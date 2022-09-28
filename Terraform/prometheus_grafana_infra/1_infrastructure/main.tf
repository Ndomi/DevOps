locals {
    prefix = "managing-alb-using-terraform"
    vpc_name = "${local.prefix}-vpc"
    vpc_cidr = "10.0.0.0/16"
    common_tags = {
        Environment = "dev"
        Project = "hands-on.cloud"
    }
}

/* locals {
  remote_state_bucket_region    = "eu-west-1"
  remote_state_bucket           = "prom-graf1012"
  infrastructure_state_file     = "myKey"

  prefix          = data.terraform_remote_state.infrastructure.outputs.prefix
  common_tags     = data.terraform_remote_state.infrastructure.outputs.common_tags
  vpc_id          = 
  public_subnets  = data.terraform_remote_state.infrastructure.outputs.public_subnets
  private_subnets = data.terraform_remote_state.infrastructure.outputs.private_subnets
} */

data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    bucket = "prom-graf1012"
    region = "eu-west-1"
    key    = "myKey"
  }
}