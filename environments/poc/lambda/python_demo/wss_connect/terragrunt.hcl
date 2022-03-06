include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/lambda/aws//?version=2.34.1"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  function_name = "${local.env_vars.locals.lambda_prefix_name}-connect"
  description   = "lambda example of websocket connect"
  handler       = "wss-conn.lambda_handler"
  runtime       = "python3.8"

  create_role   = true

  create_package      = false
  s3_existing_package = {
    bucket = "S3 bucket"
    key    = "wss-conn.zip"
  }

  tags = {
    "Managed By" = "Terragrunt"
  }
}
