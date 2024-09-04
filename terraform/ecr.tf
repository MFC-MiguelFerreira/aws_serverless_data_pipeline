module "docker_image" {
  source = "terraform-aws-modules/lambda/aws//modules/docker-build"

  ecr_repo = module.ecr.repository_name

  use_image_tag = false

  source_path = "../"
  platform    = "linux/amd64"
}

module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name         = "lambda-ecr-image"
  repository_force_delete = true

  create_lifecycle_policy = false

  repository_lambda_read_access_arns = [module.lambda_function_with_docker_build_from_ecr.lambda_function_arn]
}