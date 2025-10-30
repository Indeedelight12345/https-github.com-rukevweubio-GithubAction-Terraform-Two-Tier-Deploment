



provider "aws" {
  region = "us-east-1"
}


resource "random_id" "suffix_key" {
  byte_length = 2
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key-${random_id.suffix_key.hex}"
  public_key = file(var.ssh_public_key_path)
}


data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


module "network" {
  source            = "./modules/networks"
  ssh_cidr_block    = var.ssh_cidr_block
 
}

module "database" {
  source            = "./modules/database"
  db_subnet_ids     = [module.network.private_subnet_1_id, module.network.private_subnet_2_id]
  rds_sg_id         = module.network.rds_sg_id
  db_password       = var.db_password
  db_instance_class = var.db_instance_class  
}

module "compute" {
  source        = "./modules/compute"
  environment         = var.environment
  ami_id        = data.aws_ami.ubuntu_2204.id
  subnet_id     = module.network.public_subnet_id
  sg_id         = module.network.frontend_sg_id
  key_name      = aws_key_pair.my_key.key_name
  instance_type = var.instance_type           
}