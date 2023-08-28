terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         	   = "kpa23-instructor-s3-tfstate"
    key              	 = "state/terraform-components.tfstate"
    region         	   = "eu-west-1"
    encrypt        	   = true
    dynamodb_table     = "terraform-up-and-running-locks"
  }
}

provider "aws" {
  region = var.aws_region
}