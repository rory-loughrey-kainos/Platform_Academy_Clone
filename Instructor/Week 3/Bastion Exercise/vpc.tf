resource "aws_vpc" "bradt_vpc" {
  
  # IP Range for the VPC
  cidr_block = "10.10.0.0/16"
  
  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
  tags = {
    Name = "bradt_vpc"
  }
}