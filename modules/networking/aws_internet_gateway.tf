resource "aws_internet_gateway" "internet_gateway" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-intgw-${count.index}" })
  )
}
