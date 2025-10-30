variable "bucket_name" {
  type    = string
  default = "my-terraform-remote-state-bucket-ubio"
}

variable "dynamodb_table_name" {
  type    = string
  default = "terraform-locks"
}
