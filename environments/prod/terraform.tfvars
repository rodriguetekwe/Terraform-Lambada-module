function_name          = "prod-lambda-function"
description            = "Production Lambda function"
handler                = "index.handler"
runtime                = "nodejs20.x"
memory_size            = 256
timeout                = 10
log_retention_in_days  = 30
region                 = "us-east-1"
environment_variables  = {
  ENVIRONMENT = "production"
  DEBUG       = "false"
}
policies = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
]
tags = {
  Environment = "prod"
  Team        = "Production"
}
