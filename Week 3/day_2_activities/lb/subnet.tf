resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id

  count = var.subnet_count.public

  cidr_block = var.public_subnet_cidr[count.index]

  tags = {
    Name = "public-subnet-rory-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  
  vpc_id = aws_vpc.vpc.id

  count = var.subnet_count.private

  cidr_block = var.private_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-rory-${count.index}"
  }
}