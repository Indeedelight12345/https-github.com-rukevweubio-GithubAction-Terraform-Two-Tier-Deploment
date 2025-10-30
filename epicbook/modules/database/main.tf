resource "random_id" "suffix" {
  byte_length = 2
}

resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group-${random_id.suffix.hex}"
  subnet_ids = var.db_subnet_ids
  tags       = { Name = "db-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  allocated_storage               = 20
  engine                          = "mysql"
  engine_version                  = "8.0"
  instance_class                  = "db.t3.micro"
  username                        = "admin"
  password                        = var.db_password
  db_subnet_group_name            = aws_db_subnet_group.main.name
  vpc_security_group_ids          = [var.rds_sg_id]
  publicly_accessible             = false
  skip_final_snapshot             = false
  deletion_protection             = false
  monitoring_interval             = 0
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery", "audit"]
}