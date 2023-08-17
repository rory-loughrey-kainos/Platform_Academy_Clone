variable "region" {
  default = "eu-west-1"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "profile_name" {
  default = "default"
}
variable "vpc_cidr" {
  default = "178.0.0.0/16"
}
variable "public_subnet_cidr" {
  default = "178.0.10.0/24"
}

variable "private_ips" {
    type        = list(string)
    description = "List of trusted Kainos IP addresses"
}