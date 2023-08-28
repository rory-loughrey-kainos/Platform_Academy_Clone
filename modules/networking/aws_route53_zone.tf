resource "aws_route53_zone" "private" {
  name = var.internal_domain_name

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  force_destroy = true

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-private-dns-zone" })
  )
}

