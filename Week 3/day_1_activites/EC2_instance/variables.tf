variable "root_name" {
  type        = string
  default     = "rl-ec2-"
  description = "forename for all deployed resources"
}

variable "private_ips" {
  type        = list(string)
  description = "List of trusted Kainos IP addresses"
  default     = ["165.255.197.141"]
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