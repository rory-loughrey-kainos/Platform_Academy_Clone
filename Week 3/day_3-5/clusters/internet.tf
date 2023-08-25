resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-rory.id
  tags = {
    Name = "ig${var.root-name}"
  }
}

resource "aws_eip" "internet_ip_0" {
  domain = "vpc"

  tags = {
    Name = "eip-0${var.root-name}"
  }
}

resource "aws_eip" "internet_ip_1" {
  domain = "vpc"

  tags = {
    Name = "eip-1${var.root-name}"
  }
}