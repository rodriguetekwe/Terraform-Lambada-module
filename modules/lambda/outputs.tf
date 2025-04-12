# outputs.tf
output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "role_arn" {
  description = "ARN of the IAM execution role"
  value       = coalesce(var.role_arn, try(aws_iam_role.lambda_exec[0].arn, null))
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.lambda.name
}

output "lambda_version" {
  description = "Latest published version of the Lambda function"
  value       = aws_lambda_function.this.version
}

output "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = aws_lambda_function.this.invoke_arn
}