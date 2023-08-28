//Main VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    local.default_tags,
    tomap({ "Name" = "${local.naming_prefix}-vpc" })
  )
}

