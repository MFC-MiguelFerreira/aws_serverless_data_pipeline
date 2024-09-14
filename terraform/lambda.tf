module "lambda_function_with_docker_build_from_ecr" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.infrastucture_prefix_name}_extract"
  description   = "Lambda function to extract the data from the source."

  environment_variables = {
    raw_bucket_name = aws_s3_bucket.raw_datalake_bucket.bucket
  }

  ##################
  # Container Image
  ##################
  create_package = false

  package_type  = "Image"
  architectures = ["x86_64"]

  image_uri            = module.docker_image.image_uri
  image_config_command = ["lambdas/extract.handler"]

  ##################
  # Policy
  ##################
  attach_policy_statements = true
  policy_statements = {
    s3_read = {
      effect    = "Allow",
      actions   = ["s3:PutObject", "s3:GetObject"],
      resources = ["${aws_s3_bucket.raw_datalake_bucket.arn}", "${aws_s3_bucket.raw_datalake_bucket.arn}/*"]
    }
  }
}