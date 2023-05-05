# create the VPC
resource "aws_vpc" "vpc_main" {
  cidr_block       = "192.168.0.0/23"
  instance_tenancy = "default"

  #enable dns in subnet
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "bradt-vpc"
  }
}

# allocate the private subnet ranges
resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "192.168.1.0/25"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "private-a-subnet"
  } 
}
resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "192.168.1.128/25"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = true
  tags = {
    Name = "private-b-subnet"
  }
}

# allocate the public subnet ranges
resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "192.168.0.0/25"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-a-subnet"
  }
}
resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "192.168.0.128/25"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-b-subnet"
  }
}