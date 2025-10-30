variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR for first private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR for second private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "availability_zone_a" {
  type    = string
  default = "us-east-1a"
}

variable "availability_zone_b" {
  type    = string
  default = "us-east-1b"
}

variable "ssh_cidr_block" {
  description = "CIDR allowed for SSH"
  type        = string
  default = "0.0.0.0/0"
}