resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
    name = "terraform-lock"
    hash_key = "LockID"
    read_capacity = 5
    write_capacity = 5

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
      "Name" = "terraformLock Table"
    }
}