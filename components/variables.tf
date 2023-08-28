variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "internal_domain_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "nat_gateway_count" {
  type = string
}

variable "root-name" {
  type = string
  default = "-KPA-23-rory"
}
