module "networking" {
  source = "../modules/networking"

  region               = var.aws_region
  project              = var.project
  environment          = var.environment
  internal_domain_name = var.internal_domain_name
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  nat_gateway_count    = var.nat_gateway_count

}
