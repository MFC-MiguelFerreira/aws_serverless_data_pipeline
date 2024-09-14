output "raw_datalake_bucket_name" {
  value = aws_s3_bucket.raw_datalake_bucket.bucket
}

output "curated_datalake_bucket_name" {
  value = aws_s3_bucket.curated_datalake_bucket.bucket
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "ecr_docker_image_uri" {
  value = module.docker_image.image_uri
}

output "lambda_function_name" {
  value = module.lambda_function_with_docker_build_from_ecr.lambda_function_name
}
