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

provider "docker" {
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", local.account_id, var.aws_region)
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
