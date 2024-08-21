resource "aws_s3_bucket" "raw" {
  bucket = "00-raw-${var.account_id}"
  tags = {
    "stage" = "dev"
  }
}