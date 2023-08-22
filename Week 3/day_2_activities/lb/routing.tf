resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "public-rt-rory"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  count          = var.subnet_count.public
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "private_rt_asso" {
  count          = var.subnet_count.private
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
