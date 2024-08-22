variable "aws_profile_name" {
  type        = string
  description = "AWS profile locally configured with aws configure or aws configure sso command."
  nullable    = false
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the infrastructure."
  nullable    = false
}

variable "environment" {
  type        = string
  description = "The development environment (e.g. dev/prd)"
  nullable    = false
  default     = "dev"
}

variable "infrastucture_tag" {
  type        = string
  description = "Cost tracker tag (e.g. terraform_serverless_data_pipeline)."
  nullable    = true
}