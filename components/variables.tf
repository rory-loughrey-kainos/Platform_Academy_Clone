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
  type    = string
  default = "-KPA-23-rory"
}

variable "instance_count" {
  type        = number
  description = "nummber of ec2 instances to generate"
  default     = 2
}

variable "instance_type" {
  type        = string
  description = "sku of machine to spin-up"
  default     = "t3.micro"
}

variable "naming_prefix" {
  type        = string
  description = "prefix to identify deployed resources"
  default     = "rory-"
}
