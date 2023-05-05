resource "aws_internet_gateway" "bradt_internet_gateway" {
  depends_on = [
    aws_vpc.bradt_vpc,
    aws_subnet.bradt_public_subnet,
    aws_subnet.bradt_private_subnet
  ]
  
  # VPC in which it has to be created!
  vpc_id = aws_vpc.bradt_vpc.id

  tags = {
    Name = "IG-Public-&-Private-VPC"
  }
}