//pub
resource "aws_route_table" "pub_gw_table" {
  count = var.counts.public_subnets

  vpc_id = aws_vpc.vpc-rory.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "pub-table-${count.index}${var.root-name}"
  }
}

resource "aws_route_table_association" "pub_table_assoc" {
  count          = var.counts.public_subnets
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.pub_gw_table[count.index].id
}

//priv
resource "aws_route_table" "priv_nat_table" {
  count = var.counts.private_subnets

  vpc_id = aws_vpc.vpc-rory.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = [count.index] == 0 ? aws_nat_gateway.priv_nat_0.id : aws_nat_gateway.priv_nat_1.id
  }

  tags = {
    Name = "priv-table-${count.index}${var.root-name}"
  }
}

resource "aws_route_table_association" "priv_table_assoc" {
  count          = var.counts.private_subnets
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.priv_nat_table[count.index].id
}