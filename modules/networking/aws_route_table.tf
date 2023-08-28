resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-vpc-public-routetable" })
  )
}

resource "aws_route_table" "private" {
  count = var.nat_gateway_count

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-vpc-private-routetable-${count.index}" })
  )
}
