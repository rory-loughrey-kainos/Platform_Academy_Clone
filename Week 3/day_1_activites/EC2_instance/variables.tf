variable "root_name" {
  type        = string
  default     = "rl-ec2-"
  description = "forename for all deployed resources"
}

variable "db_password" {
  type        = string
  default     = "Password123"
  description = "super secret password"
}

variable "location" {
  type        = string
  default     = "eu-west-1"
  description = "aws az"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_ips" {
  type        = list(string)
  description = "List of trusted Kainos IP addresses"
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
    "165.225.16.0/23"
  ]
}