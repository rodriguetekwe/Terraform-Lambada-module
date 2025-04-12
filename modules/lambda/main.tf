# main.tf
resource "aws_iam_role" "lambda_exec" {
  count = var.role_arn == null ? 1 : 0

  name               = "${var.function_name}-exec-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  count = var.role_arn == null ? 1 : 0

  role       = aws_iam_role.lambda_exec[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "additional_policies" {
  count = var.role_arn == null ? length(var.policies) : 0

  role       = aws_iam_role.lambda_exec[0].name
  policy_arn = element(var.policies, count.index)
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description   = var.description
  role          = coalesce(var.role_arn, try(aws_iam_role.lambda_exec[0].arn, null))
  
  dynamic "vpc_config" {
    for_each = length(var.security_group_ids) > 0 && length(var.subnet_ids) > 0 ? [1] : []
    content {
      security_group_ids = var.security_group_ids
      subnet_ids         = var.subnet_ids
    }
  }

  handler     = var.handler
  runtime     = var.runtime
  memory_size = var.memory_size
  timeout     = var.timeout
  layers      = var.layers
  kms_key_arn = var.kms_key_arn

  environment {
    variables = var.environment_variables
  }


  filename         = var.source_path != null ? var.source_path : null

  depends_on = [
    aws_cloudwatch_log_group.lambda
  ]

  tags = var.tags
}

resource "aws_lambda_function_event_invoke_config" "this" {
  function_name          = aws_lambda_function.this.function_name
  maximum_retry_attempts = 0
}