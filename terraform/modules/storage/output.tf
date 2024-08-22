output "bucket_ids" {
  description = "List of all bucket IDs created"
  value       = values(aws_s3_bucket.datalake_buckets)[*].id
}