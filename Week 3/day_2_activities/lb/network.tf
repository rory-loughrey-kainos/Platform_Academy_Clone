resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "vpc-gateway-rory"
  }
}

resource "aws_eip" "eip" {
  vpc = true

  depends_on = [aws_internet_gateway.gateway]
  tags = {
    Name = "rl_EC2_eip"
  }
}
/*
resource "aws_nat_gateway" "gateway" {

  count = var.counts.public
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "nat_gateway_rory"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.eip]
}
*/


