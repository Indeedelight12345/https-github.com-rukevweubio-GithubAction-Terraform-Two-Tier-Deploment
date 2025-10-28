variable "db_password" {
    description = "The password for the RDS MySQL database."
    default =  "rootPassword123"
    sensitive   = true
}

variable "ssh_public_key_path" {
    description = "The file path to your SSH public key (e.g., ~/.ssh/id_rsa.pub)."
    type        = string
    default     = "id_rsa.pub"
}

variable "ssh_cidr_block" {
    description = "The CIDR block to allow SSH access from (e.g., your public IP address with a /32 suffix)."
    type        = string
    default     = "0.0.0.0/0"
}

variable "private_subnet" {
    description = "the value of teh private subnet "
    type= string 
    default = "10.0.3.0/24"
  
}