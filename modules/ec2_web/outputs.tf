output "vpc_id" {
  value = var.vpc_id
}

output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}
/*
output "public_subnets_ids" {
  value = var.public_subnets.*.id
}

output "private_subnets_ids" {
  value = var.private_subnets.*.id
}

output "all_route_tables_ids" {
  value = compact([
    length(aws_route_table.public.*) == 1 ? aws_route_table.public[0].id : "",
    length(aws_route_table.private.*) == 1 ? aws_route_table.private[0].id : "",
  ])
}

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "r53_private_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway[0].id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway[0].id
}

output "nat_gateway_public_ip" {
  value = aws_nat_gateway.nat_gateway[0].public_ip
}

output "private_subnets_cidr" {
  value = aws_subnet.private.*.cidr_block
}

output "public_subnets_cidr" {
  value = aws_subnet.public.*.cidr_block
}
*/

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_id" {
  value = aws_lb.alb.dns_name
}
