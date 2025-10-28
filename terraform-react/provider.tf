terraform {
  backend "s3" {
    bucket         = "my-terraformstate-lock-ubio20251028" 
    key            = "devopterraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-east"
    encrypt        = true
  }
}
