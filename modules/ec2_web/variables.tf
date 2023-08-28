variable "instance_count" {
  type = number
  description = "nummber of ec2 instances to generate"
}

variable "instance_type" {
  type = string
  description = "sku of machine to spin-up"
}

variable "region" {
  type        = string
  description = "Deployment region for this module"
}

variable "project" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type        = string
  description = "Deployment environment for this module"
}

variable "internal_domain_name" {
  type        = string
  description = "Internal domain name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC"
}

variable "vpc_id" {
  type = string
  description = "id of vpc"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids."
}

variable "public_routing_table" {
  type = list(string)
  description = "routing table for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets."
}

variable "private_routing_table" {
  type = list(string)
  description = "routing table for private subnets"
}

variable "nat_gateway_count" {
  type        = number
  description = "Number of NAT Gateways"
}

variable "route53_zone" {
  type = string
  description = "private DNS zone"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "id's of each and every priv subnet"
}