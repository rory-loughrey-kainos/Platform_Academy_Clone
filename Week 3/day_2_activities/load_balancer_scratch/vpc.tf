resource "aws_vpc" "vpc-rory" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "vpc${var.root-name}"
  }
}

data "aws_availability_zones" "available" {}
