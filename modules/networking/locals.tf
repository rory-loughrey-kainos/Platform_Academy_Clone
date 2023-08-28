locals {

  naming_prefix = "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Component   = "Networking"
    Environment = var.environment
  }

  # Create subnet availability zone map

  subnet_az_map = {
    for idx, az in data.aws_availability_zones.available.names : az => {
      route_table_id = element(aws_route_table.private, idx).id
      subnet_count   = length([for s in aws_subnet.private : s if s.availability_zone == az])
    }
  }

  availability_zone_count = length(data.aws_availability_zones.available.names)

}
