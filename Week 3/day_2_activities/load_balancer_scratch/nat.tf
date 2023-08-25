resource "aws_nat_gateway" "priv_nat" {
  count = var.counts.public_subnets
  subnet_id         = aws_subnet.public[count.index].id
  connectivity_type = "public"
  allocation_id = aws_eip.internet_ip_0.id

  tags = {
    Name = "nat-gateway${count.index}${var.root-name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}