locals {

  naming_prefix = "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Component   = "Networking"
    Environment = var.environment
  }

  //Using a local, this gets all the IDs of the dynamically created EC2 instances from both zones and addes them two one list of IDs
  web_instance_ids = concat(aws_instance.web_zone_a[*].id)

  # Create subnet availability zone map

/*
  subnet_az_map = {
    for idx, az in data.aws_availability_zones.available.names : az => {
      route_table_id = element(var.private_routing_table, idx).id
      subnet_count   = length([for s in var.private_subnets : s if s.availability_zone == az])
    }
  }
*/
  availability_zone_count = length(data.aws_availability_zones.available.names)
}

data "aws_availability_zones" "available" {
  state = "available"
}
