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
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "number of subnets to generate"
  type        = map(number)
  default = {
    public  = 1
    private = 2
  }
}
variable "public_subnet_cidr" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24"
  ]

}

variable "trusted_ips" {
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
    "165.225.16.0/23",
    "165.225.80.0/22",
    "147.161.166.0/23",
    "147.161.140.0/23",
    "147.161.142.0/23",
    "147.161.144.0/23"
  ]
}

variable "bucket_name" {
  default = "alb-bucket-logs-rory-kainos"
  type = string
  description = "name of loggin bucket"
}