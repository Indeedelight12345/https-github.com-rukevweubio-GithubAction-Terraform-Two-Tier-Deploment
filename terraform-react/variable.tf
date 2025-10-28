variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  type        = string
  default     = "id_rsa.pub"
}

variable "ssh_cidr_block" {
  description = "Trusted IP address or CIDR for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}


variable "backend_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
  default = "tfstate_east"
}

variable "backend_region" {
  description = "Region for Terraform backend"
  type        = string
  default = "us-east-1"
}

variable "backend_lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
  default ="terraform-lock-east"
}