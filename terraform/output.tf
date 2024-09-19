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

output "step_function_name" {
  value = module.step_function.state_machine_name
}

output "aws_glue_catalog_raw_database_name" {
  value = aws_glue_catalog_database.raw.name
}

output "aws_glue_catalog_curated_database_name" {
  value = aws_glue_catalog_database.curated.name
}

output "eventbridge_rule" {
  value = module.eventbridge.eventbridge_rules
}
