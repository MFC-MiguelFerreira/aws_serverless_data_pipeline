module "storage" {
  source = "./modules/storage"

  bucket_names = ["raw", "curated"]
  account_id   = local.account_id
}

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
  # image_config_entry_point = ["lambdas/extract.handler"]

  # handler = "lambdas/extract.handler"
}

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
