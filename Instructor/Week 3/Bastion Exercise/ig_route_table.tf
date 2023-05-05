resource "aws_route_table" "bradt_public_subnet_rt" {
  depends_on = [
    aws_vpc.bradt_vpc,
    aws_internet_gateway.bradt_internet_gateway
  ]

   # VPC ID
  vpc_id = aws_vpc.bradt_vpc.id

  # NAT Rule
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bradt_internet_gateway.id
  }

  tags = {
    Name = "Route Table for Internet Gateway"
  }
}


resource "aws_route_table_association" "rt_ig_association" {

  depends_on = [
    aws_vpc.bradt_vpc,
    aws_subnet.bradt_public_subnet,
    aws_subnet.bradt_private_subnet,
    aws_route_table.bradt_public_subnet_rt
  ]

# Public Subnet ID
  subnet_id      = aws_subnet.bradt_public_subnet.id

#  Route Table ID
  route_table_id = aws_route_table.bradt_public_subnet_rt.id
}