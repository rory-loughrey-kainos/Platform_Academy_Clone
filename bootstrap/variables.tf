variable "project" {
  type        = string
  description = "The name of the project we are bootstrapping."
}

variable "aws_region" {
  type        = string
  description = "The AWS Region into which we are bootstrapping."
  default     = "eu-west-1"
}

variable "environment" {
  type        = string
  description = "The name of the environment for the bootstrapping process."
  default     = "state"
}

variable "component" {
  type        = string
  description = "The name of the component for the bootstrapping process."
  default     = "state"
}

variable "aws_account_id" {
  type        = string
  description = "ID of the AWS Account"
}

variable "root-name" {
  type    = string
  default = "-kpa-23-rory"
}