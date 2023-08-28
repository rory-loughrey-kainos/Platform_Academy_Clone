terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "remote-tfstate-state-s3-tfstate-kpa-23-rory"
    key            = "state/terraform-components.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-up-and-running-locks-kpa-23-rory"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}