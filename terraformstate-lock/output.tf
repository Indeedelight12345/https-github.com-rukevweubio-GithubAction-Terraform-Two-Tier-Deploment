output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "The ID of the main VPC"
}

output "subnet_id" {
  value       = aws_subnet.my_subnet.id
  description = "The ID of the subnet"
}

output "bucket_east_name" {
  value       = aws_s3_bucket.bucket_east.bucket
  description = "Name of the S3 bucket in us-east-1"
}

output "bucket_west_name" {
  value       = aws_s3_bucket.bucket_west.bucket
  description = "Name of the S3 bucket in us-west-2"
}
