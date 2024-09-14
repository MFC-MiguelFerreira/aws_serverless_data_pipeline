locals {
  curated_processing = templatefile(
    "../sql/merge/currency_exchange.sql",
    {
      raw_database_name     = aws_glue_catalog_database.raw.name,
      raw_table_name        = aws_glue_catalog_table.currency_exchange_raw.name,
      curated_database_name = aws_glue_catalog_database.curated.name,
      curated_table_name    = aws_glue_catalog_table.currency_exchange.name
    }
  )
  raw_partitions = templatefile(
    "../sql/msck/repair_table.sql",
    {
      raw_database_name = aws_glue_catalog_database.raw.name,
      raw_table_name    = aws_glue_catalog_table.currency_exchange_raw.name
    }
  )
}

module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"

  name = "${var.infrastucture_prefix_name}"
  definition = templatefile(
    "../pipe/step_function.asl.json",
    {
      lambda_function_arn = module.lambda_function_with_docker_build_from_ecr.lambda_function_arn,
      curated_processing  = jsonencode(local.curated_processing),
      raw_partitions      = jsonencode(local.raw_partitions)
    }
  )

  service_integrations = {
    lambda = {
      lambda = [module.lambda_function_with_docker_build_from_ecr.lambda_function_arn]
    }

    athena_StartQueryExecution_Sync = {
      athena = [
        "arn:aws:athena:${var.aws_region}:${local.account_id}:workgroup/primary",
        "arn:aws:athena:${var.aws_region}:${local.account_id}:datacatalog/*"
      ]
      glue = [
        "arn:aws:glue:${var.aws_region}:${local.account_id}:catalog",
        "arn:aws:glue:${var.aws_region}:${local.account_id}:database/*",
        "arn:aws:glue:${var.aws_region}:${local.account_id}:table/*",
        "arn:aws:glue:${var.aws_region}:${local.account_id}:userDefinedFunction/*"
      ]
      s3            = true
      lakeformation = true
    }
  }
}
