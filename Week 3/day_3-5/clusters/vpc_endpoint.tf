resource "aws_vpc_endpoint" "ecr_connection" {
  vpc_id              = aws_vpc.vpc-rory.id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name = "endpoint to ECR - Rory"
  }
}