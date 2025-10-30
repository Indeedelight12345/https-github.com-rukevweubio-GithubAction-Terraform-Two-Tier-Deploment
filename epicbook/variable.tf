

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class (e.g., db.t3.micro)"
  type        = string
}


variable "db_password" {
  description = "The password for the RDS MySQL database."
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "id_rsa.pub"
}

variable "ssh_cidr_block" {
  description = "CIDR for SSH access"
  type        = string
}