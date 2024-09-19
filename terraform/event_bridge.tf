module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    "${var.infrastucture_prefix_name}" = {
      name                = "${var.infrastucture_prefix_name}_rule_cron"
      description         = "Run state machine everyday 16:05 UTC"
      schedule_expression = "cron(0/15 12-20 ? * MON,TUE,WED,THU,FRI *)" // Every 15 minutes, between 12:00 PM and 08:59 PM, only on Monday, Tuesday, Wednesday, Thursday, and Friday
      enabled             = true
    }
  }

  targets = {
    "${var.infrastucture_prefix_name}" = [
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
