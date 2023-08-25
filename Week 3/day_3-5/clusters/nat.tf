resource "aws_nat_gateway" "priv_nat_0" {
  subnet_id         = aws_subnet.public[0].id
  connectivity_type = "public"
  allocation_id     = aws_eip.internet_ip_0.id

  tags = {
    Name = "nat-gateway-0${var.root-name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "priv_nat_1" {
  subnet_id         = aws_subnet.public[1].id
  connectivity_type = "public"
  allocation_id     = aws_eip.internet_ip_1.id

  tags = {
    Name = "nat-gateway-1${var.root-name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}