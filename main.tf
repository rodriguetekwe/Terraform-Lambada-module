module "lambda_function" {
  source = "./modules/lambda"

  function_name          = var.function_name
  description            = var.description
  handler                = var.handler
  runtime                = var.runtime
  memory_size            = var.memory_size
  timeout                = var.timeout
  source_path           = "../scripts/lambda_function.zip"
  log_retention_in_days  = var.log_retention_in_days
  region                 = var.region
  environment_variables  = var.environment_variables

  policies = var.policies

  tags = var.tags
}

terraform {
  backend "s3" {
    bucket         = "backend-tf-097756506425"
    key            = "multiple-env/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}