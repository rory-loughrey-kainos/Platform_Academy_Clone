# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "192.168.0.0/16"
}

# AWS AZ
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

variable "aws_azs" {
  type        = list(string)
  description = "AWS sub-regions"
  default     = ["a", "b", "c"]
}

variable "db_password" {
  type        = string
  default     = "Password123"
  description = "super secret password"
}

variable "ec2_type" {
  type    = string
  default = "t3.micro"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["192.168.0.0/25", "192.168.0.128/25"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["192.168.1.0/25", "192.168.1.128/25"]
}

variable "root-name" {
  type    = string
  default = "-ecs-rory"
}

//ips
variable "trusted_ips" {
  type        = list(string)
  description = "apply trusted ips from tfvars"
  default = [
    "62.254.63.50/32",  # KAINOS BELFAST OFFICE
    "62.254.63.52/32",  # KAINON BELFAST VPN
    "195.89.171.5/32",  # KAINOS BELFAST VPN backup line
    "147.161.236.0/23", # Zscaler Ranges for UK
    "165.225.196.0/23",
    "165.225.198.0/23",
    "147.161.224.0/23",
    "165.225.80.0/22",
    "147.161.166.0/23",
    "147.161.224.0/23",
    "165.225.16.0/23",
    "165.225.80.0/22",
    "147.161.166.0/23",
    "147.161.140.0/23",
    "147.161.142.0/23",
    "147.161.144.0/23"
  ]
}

variable "ssh_filename" {
  type        = string
  description = "specify a filepath for the ssh key"
  default     = "~/.ssh/simple-web-jb.pub"
}

//counts
variable "counts" {
  type        = map(number)
  description = "counts of resources to deploy"
  default = {
    "public_subnets"  = 2,
    "private_subnets" = 2,
    "instances"       = 2
  }
}