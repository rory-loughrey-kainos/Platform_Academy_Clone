module "ec2_web" {
  source = "../modules/ec2_web"

  vpc_id = module.networking.vpc_id

  region               = var.aws_region
  project              = var.project
  environment          = var.environment
  internal_domain_name = var.internal_domain_name
  vpc_cidr_block       = var.vpc_cidr_block

  public_subnets    = var.public_subnets
  public_subnet_ids = module.networking.public_subnets_ids

  private_subnets    = var.private_subnets
  private_subnet_ids = module.networking.private_subnets_ids

  nat_gateway_count = var.nat_gateway_count

  instance_count = var.instance_count
  instance_type  = var.instance_type

  private_routing_table = module.networking.private_route_table_ids
  public_routing_table  = module.networking.public_route_table_ids

  route53_zone = module.networking.r53_private_zone_id

}
