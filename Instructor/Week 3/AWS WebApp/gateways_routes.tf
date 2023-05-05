# public routes and gateways
##############################
# create an internet gateway
resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "bradt-vpc-internetgw"
  }
}

# add as default route in public subnet to forward outbound to
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_main.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internetgw.id
  }
  tags = {
    "Name" = "bradt-rt-public"
  }
}

# add routes for public subnets to public route table
resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id = aws_subnet.public_b.id
  route_table_id = aws_route_table.rt_public.id
}


# private routes and gateways
###############################
# create an eip for the natgw
resource "aws_eip" "natgw_elastic_ip" {
  vpc = true
  tags = {
    "Name" = "bradt-natgw-elastic-ip"
  }
}

# create the natgw
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_elastic_ip.id
  subnet_id = aws_subnet.public_a.id
  tags = {
      "Name" = "bradt-vpc-natgw"
  }
}

# add natgw as default route in private subnet to forward outbound to
resource "aws_route_table" "rt_private" {
    vpc_id = aws_vpc.vpc_main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw.id
    }

    tags = {
      "Name" = "bradt-rt-private"
    }
}

# add routes for private subnets to private route table
resource "aws_route_table_association" "private_a" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private.id
}