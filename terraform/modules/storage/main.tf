locals {
  indexed_bucket_names = { 
    for idx, name in var.bucket_names : 
    format("%02d", idx) => "${format("%02d", idx)}-${name}-${var.account_id}" 
  }
}

resource "aws_s3_bucket" "datalake_buckets" {
  for_each = local.indexed_bucket_names

  bucket = each.value
}
