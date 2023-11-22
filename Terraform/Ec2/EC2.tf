# Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZDSU5ROPAI5M2FJU"
  secret_key = "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"
}


# Resource
resource "aws_instance" "my-instance" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name      = "ksnv_key"

  #   security_groups        = ["my_sg"]
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_pub_subnet_01.id

  for_each = toset(["Jenkins_master", "Ansible", "Slave"])
  tags = {
    Name = "${each.key}"
  }
}


# Security_groups
resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-port"
  }
}


# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}


# Subnet
resource "aws_subnet" "my_pub_subnet_01" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_pub_subnet_01"
  }
}

resource "aws_subnet" "my_pub_subnet_02" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_pub_subnet_02"
  }
}

# Internet_Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}


# Route_Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}


# Route_Table_assocation
resource "aws_route_table_association" "my_rta_pub_subnet_01" {
  subnet_id      = aws_subnet.my_pub_subnet_01.id
  route_table_id = aws_route_table.my_rt.id
}
resource "aws_route_table_association" "my_rta_pub_subnet_02" {
  subnet_id      = aws_subnet.my_pub_subnet_02.id
  route_table_id = aws_route_table.my_rt.id
}