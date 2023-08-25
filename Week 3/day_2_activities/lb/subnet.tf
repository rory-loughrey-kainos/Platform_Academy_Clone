resource "aws_subnet" "public_subnet" {
  count = var.counts.public

  vpc_id = aws_vpc.vpc.id

  cidr_block = var.public_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-subnet${count.index}-rory"
  }
}
/*
resource "aws_subnet" "private_subnet" {

  vpc_id = aws_vpc.vpc.id

  count = var.counts.private

  cidr_block = var.private_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-rory-${count.index}"
  }
}
*/