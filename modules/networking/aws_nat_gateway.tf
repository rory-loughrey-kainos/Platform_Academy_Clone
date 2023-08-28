resource "aws_nat_gateway" "nat_gateway" {
  count = var.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-natgw-${count.index}" })
  )

  depends_on = [aws_internet_gateway.internet_gateway]
}
