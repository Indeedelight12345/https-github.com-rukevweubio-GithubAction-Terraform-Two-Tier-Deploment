output "db_subnet_group_name" {
  value = aws_db_subnet_group.main.name
}

output "rds_instance_id" {
  value = aws_db_instance.mysql.id
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}