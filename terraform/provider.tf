terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.aws_profile_name
  region  = var.aws_region
  default_tags {
    tags = {
      "environment" : var.environment
      "cost_tracker" : var.infrastucture_tag
    }
  }
}