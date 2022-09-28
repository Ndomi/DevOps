terraform {
  backend "s3" {
    bucket = "prom-graf1012"
    key = "myKey"
    region = "eu-west-1"
    encrypt = "true"
    dynamodb_table = "my_graf_dynamodb"
  }
}