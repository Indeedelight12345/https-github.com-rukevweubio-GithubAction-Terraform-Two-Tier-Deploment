terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "my-terraform-remote-state-bucket-ubio"
    key            = "epicbook/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
