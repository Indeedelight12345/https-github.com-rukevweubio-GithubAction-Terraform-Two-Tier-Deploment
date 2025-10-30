provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-remote-state-bucket-ubio"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "TerraformRemoteState"
    Environment = "bootstrap"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLocks"
    Environment = "bootstrap"
  }
}
