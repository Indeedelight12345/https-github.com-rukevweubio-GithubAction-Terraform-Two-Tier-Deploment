
provider "aws" {
  region = var.bucket_regions["bucket_east"]
  alias  = "us_east_1"
}

provider "aws" {
  region = var.bucket_regions["bucket_west"]
  alias  = "us_west_2"
}


resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "main-vpc" }
}


resource "aws_subnet" "my_subnet" {
  vpc_id                          = aws_vpc.main_vpc.id
  cidr_block                      = var.subnet_cidr
  availability_zone               = var.subnet_az
}


resource "aws_internet_gateway" "my_internetgateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = { Name = "myigw" }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internetgateway.id
  }

  tags = { Name = "public-route-table" }
}


resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_s3_bucket" "bucket_east" {
  provider = aws.us_east_1
  bucket   = var.buckets["bucket_east"]
  acl      = "private"


  tags = { Name = "MyBucketEast" }
}

# resource "aws_s3_bucket_versioning" "bucket_east_versioning" {
#   bucket = aws_s3_bucket.bucket_east.id
#   versioning_configuration {
#     status = "Disabled"
#   }
# }

resource "aws_s3_bucket" "bucket_west" {
  provider = aws.us_west_2
  bucket   = var.buckets["bucket_west"]
  acl      = "private"

 tags = { Name = "MyBucketWest" }
}

# resource "aws_s3_bucket_versioning" "bucket_west_versioning" {
#   bucket = aws_s3_bucket.bucket_west.id
#   versioning_configuration {
#     status = "Disabled"
#   }
# }

