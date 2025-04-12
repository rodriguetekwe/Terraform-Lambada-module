module "lambda_function" {
  source = "./modules/lambda"

  function_name          = "my-lambda-function"
  description           = "Process incoming events"
  handler               = "index.handler"
  runtime               = "nodejs14.x"
  memory_size           = 256
  timeout               = 10
  source_path           = "scripts/lambda_function.zip"
  log_retention_in_days = 14
  region = "us-east-1"
  environment_variables = {
    ENVIRONMENT = "production"
    API_KEY     = "secret-key"
  }

  policies = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]

  tags = {
    Team        = "DevOps"
    Application = "ServerlessApp"
  }
}