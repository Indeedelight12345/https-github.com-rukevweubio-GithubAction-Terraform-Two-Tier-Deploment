terraform {
  backend "s3" {
    bucket         = "my-terraform-state-east-rukevwe-20251028" 
    key            = "two-tier-terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-east"
    encrypt        = true
  }
}

