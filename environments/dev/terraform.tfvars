function_name          = "dev-lambda-function"
description            = "Development Lambda function"
handler                = "index.handler"
runtime                = "nodejs20.x"
memory_size            = 128
timeout                = 5
log_retention_in_days  = 7
region                 = "us-east-1"
environment_variables  = {
  ENVIRONMENT = "development"
  DEBUG       = "true"
}
policies = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
]
tags = {
  Environment = "dev"
  Team        = "Development"
}
