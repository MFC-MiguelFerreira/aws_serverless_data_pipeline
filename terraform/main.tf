module "storage" {
  source = "./modules/storage"

  bucket_names = ["raw", "curated"]
  account_id   = local.account_id
}

module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"

  name       = "test-step-functions"
  definition = templatefile(
    "../pipe/step_function.asl.json",
    {
      lambda_function_arn = module.lambda_function_with_docker_build_from_ecr.lambda_function_arn
    }
  )

  service_integrations = {
    lambda = {
      lambda = [module.lambda_function_with_docker_build_from_ecr.lambda_function_arn]
    }
  }
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

  ##################
  # Policy
  ##################
  attach_policy_statements = true
  policy_statements = {
    s3_read = {
      effect    = "Allow",
      actions   = ["s3:PutObject", "s3:GetObject"],
      resources = ["arn:aws:s3:::00-raw-753251897225", "arn:aws:s3:::00-raw-753251897225/*"]
    }
  }
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
