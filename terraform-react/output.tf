
output "frontend_instance_id" {
    description = "The ID of the frontend EC2 instance."
    value       = aws_instance.reactapplication-vm.id
}





output "public_ip" {
  description = "Public IP of the frontend EC2 instance"
  value       = aws_instance.reactapplication-vm.public_ip
}


output "vpcId" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
  
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}