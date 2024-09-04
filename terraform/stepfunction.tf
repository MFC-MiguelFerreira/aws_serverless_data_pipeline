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