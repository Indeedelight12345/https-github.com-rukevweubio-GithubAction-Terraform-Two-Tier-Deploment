output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.vm[*].public_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}
