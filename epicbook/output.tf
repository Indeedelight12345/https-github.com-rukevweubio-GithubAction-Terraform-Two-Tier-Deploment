output "frontend_instance_id" {
  description = "The ID of the frontend EC2 instance."
  value       = module.compute.instance_id
}

output "rds_instance_id" {
  description = "The ID of the RDS database instance."
  value       = module.database.rds_instance_id
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database instance."
  value       = module.database.rds_endpoint
}

output "public_ip" {
  description = "Public IP of the frontend EC2 instance"
  value       = module.compute.public_ip
}