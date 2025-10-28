
provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}



resource "aws_s3_bucket" "tfstate_east" {
  provider = aws.us_east_1
  bucket   = "my-terraformstate-lock-ubio20251028"
  acl      = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "TerraformStateBucketEast"
  }
}

resource "aws_dynamodb_table" "terraform_lock_east" {
  provider     = aws.us_east_1
  name         = "terraform-lock-east"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "TerraformLockTableEast"
  }
}

