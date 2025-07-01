terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-1"
}

# SSH Key (using existing ed25519 key)
resource "aws_key_pair" "terra_key" {
  key_name   = "terra-ansible-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# Security Group to allow SSH and Jenkins
resource "aws_security_group" "terra_sg" {
  name        = "terra-ansible-sg"
  description = "Allow SSH and Jenkins web access"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins Web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-01f23391a59163da9"  # Ubuntu in eu-west-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terra_key.key_name
  vpc_security_group_ids = [aws_security_group.terra_sg.id]

  tags = {
    Name = "terra-Ansible"
  }

  # Save public IP to file for Ansible
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ../ansible/ec2_ip.txt"
  }
}

