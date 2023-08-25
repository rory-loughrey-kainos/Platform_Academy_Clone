//pub
resource "aws_subnet" "public" {

  count                   = var.counts.public_subnets
  vpc_id                  = aws_vpc.vpc-rory.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = "${var.aws_region}${var.aws_azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}${var.root-name}"
  }
}

//priv
resource "aws_subnet" "private" {

  count             = var.counts.private_subnets
  vpc_id            = aws_vpc.vpc-rory.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = "${var.aws_region}${var.aws_azs[count.index]}"


  tags = {
    Name = "private-subnet-${count.index}${var.root-name}"
  }
}