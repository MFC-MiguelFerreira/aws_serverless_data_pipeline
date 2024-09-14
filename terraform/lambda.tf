module "lambda_function_with_docker_build_from_ecr" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "test-lambda-with-docker-build-from-ecr"
  description   = "My awesome lambda function with container image by modules/docker-build and ECR repository created by terraform-aws-ecr module"

  create_package = false

  ##################
  # Container Image
  ##################
  package_type  = "Image"
  architectures = ["x86_64"] # ["arm64"]

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