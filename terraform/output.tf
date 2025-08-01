
output "frontend_instance_id" {
    description = "The ID of the frontend EC2 instance."
    value       = aws_instance.frontend.id
}

output "rds_instance_id" {
    description = "The ID of the RDS database instance."
    value       = aws_db_instance.mysql.id
}