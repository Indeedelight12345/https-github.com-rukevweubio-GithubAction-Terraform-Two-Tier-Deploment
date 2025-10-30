variable "db_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "db_password" {
  description = "RDS admin password"
  type        = string
  sensitive   = true
}



variable "db_instance_class" {
  description = "RDS instance class (e.g., db.t3.micro)"
  type        = string
}