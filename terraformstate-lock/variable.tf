
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_az" {
  description = "The Availability Zone for the subnet"
  default     = "us-east-1a"
}


variable "buckets" {
  description = "Map of bucket names"
  type        = map(string)
  default = {
    bucket_east = "my-bucket-region1-ubio"
    bucket_west = "my-bucket-region2-ubio"
  }
}

variable "bucket_regions" {
  description = "Map of bucket regions"
  type        = map(string)
  default = {
    bucket_east = "us-east-1"
    bucket_west = "us-west-2"
  }
}
