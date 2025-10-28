vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
subnet_az   = "us-east-1a"

buckets = {
  bucket_east = "my-bucket-region1-ubio"
  bucket_west = "my-bucket-region2-ubio"
}

bucket_regions = {
  bucket_east = "us-east-1"
  bucket_west = "us-west-2"
}
