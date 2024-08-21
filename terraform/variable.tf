variable "aws_profile_name" {
  type = string
  description = "AWS profile locally configured with aws configure or aws configure sso command."
  nullable = false
}

variable "aws_region" {
  type = string
  description = "AWS region to deploy the infrastructure."
  nullable = false
}