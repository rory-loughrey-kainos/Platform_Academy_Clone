resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % local.availability_zone_count]


  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-public-subnet",
      "Vpc"        = "${local.naming_prefix}-vpc}",
    "Availbility Zone" = "${data.aws_availability_zones.available.names[count.index % local.availability_zone_count]}" })
  )

}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % local.availability_zone_count]

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-private-subnet-${count.index}",
      "Vpc"        = "${local.naming_prefix}-vpc}",
    "Availbility Zone" = "${data.aws_availability_zones.available.names[count.index % local.availability_zone_count]}" })
  )
}
