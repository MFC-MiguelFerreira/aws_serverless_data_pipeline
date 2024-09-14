resource "aws_s3_bucket" "raw_datalake_bucket" {
  bucket        = "00-raw-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket" "curated_datalake_bucket" {
  bucket        = "01-curated-${local.account_id}"
  force_destroy = true
}
