variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "key_name" {
  type = string
}
variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string
}
