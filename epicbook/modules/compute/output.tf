output "instance_id" {
  value = aws_instance.frontend.id
}

output "public_ip" {
  value = aws_instance.frontend.public_ip
}