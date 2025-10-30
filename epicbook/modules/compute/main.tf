resource "random_id" "ec2_name_suffix" {
  byte_length = 2
  keepers = {
    always_update = timestamp()
  }
}

resource "aws_instance" "frontend" {
  
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get upgrade -y
                apt-get install -y nginx
                systemctl enable nginx
                systemctl start nginx
                apt-get install -y mysql-client
                curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
                apt-get install -y nodejs
                node -v
                npm -v
                systemctl restart nginx
              EOF

  tags = {
       Name = "frontend-${var.environment}-${random_id.ec2_name_suffix.hex}"
  
}
}