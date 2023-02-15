terraform {
  backend "s3" {
    bucket  = "terraform-remote-bucket-amg"
    encrypt = true
    key     = "terraform.tfstate"
    region  = "us-east-1"
  }
}