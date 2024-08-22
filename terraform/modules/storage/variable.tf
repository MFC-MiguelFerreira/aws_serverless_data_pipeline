variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "bucket_names" {
  description = "List of S3 bucket names to create"
  type        = list(string)
}