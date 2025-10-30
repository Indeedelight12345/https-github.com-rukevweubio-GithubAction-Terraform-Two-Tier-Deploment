variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
}



variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_pair" {
  description = "Name of the key pair"
  type        = string
  default = "id_rsa.pub"
}

variable "my_ip" {
  description = "IP allowed for SSH (use x.x.x.x/32)"
  type        = string
}
