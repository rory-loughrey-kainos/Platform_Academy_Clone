# Public subnet
resource "aws_subnet" "bradt_public_subnet" {
  depends_on = [
    aws_vpc.bradt_vpc
  ]

  vpc_id = aws_vpc.bradt_vpc.id
  cidr_block = "10.10.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Private subnet
resource "aws_subnet" "bradt_private_subnet" {
  depends_on = [
    aws_vpc.bradt_vpc,
    aws_subnet.bradt_public_subnet
  ]

  vpc_id = aws_vpc.bradt_vpc.id
  cidr_block = "10.10.1.0/24"
  
  tags = {
    Name = "Private Subnet"
  }
}