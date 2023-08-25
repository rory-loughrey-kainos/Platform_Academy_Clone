resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-rory.id
  tags = {
    Name = "ig-${var.root-name}"
  }
}

resource "aws_eip" "internet_ip_0" {
  tags = {
    Name = "eip-${var.root-name}"
  }
}

resource "aws_eip" "internet_ip_1" {
  tags = {
    Name = "eip-${var.root-name}"
  }
}