module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    crons = {
      name                = "${var.infrastucture_prefix_name}_rule_cron"
      description         = "Run state machine everyday 16:05 UTC"
      schedule_expression = "cron(18 19 * * ? *)"
    }
  }

  targets = {
    crons = [
      {
        name            = "${var.infrastucture_prefix_name}_rule_target"
        arn             = "${module.step_function.state_machine_arn}"
        attach_role_arn = true
        input           = jsonencode({ "currency" : "USD-BRL" })
      }
    ]
  }

  sfn_target_arns   = ["${module.step_function.state_machine_arn}"]
  attach_sfn_policy = true
}
