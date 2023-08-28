terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         	   = "kpa23-instructor-s3-tfstate${var.root-name}"
    key              	 = "state/terraform-components.tfstate"
    region         	   = "eu-west-1"
    encrypt        	   = true
    dynamodb_table     = "terraform-up-and-running-locks${var.root-name}"
  }
}

provider "aws" {
  region = var.aws_region
}