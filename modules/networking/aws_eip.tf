resource "aws_eip" "nat" {
  count = var.nat_gateway_count

  domain = "vpc"

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-eip-${count.index}" })
  )

}
