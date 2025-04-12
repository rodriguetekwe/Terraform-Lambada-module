# variables.tf
variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "description" {
  description = "Description of the Lambda function"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda function entrypoint handler"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "memory_size" {
  description = "Memory allocation for Lambda function in MB"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Timeout for Lambda function in seconds"
  type        = number
  default     = 3
}

variable "role_arn" {
  description = "Existing IAM role ARN for Lambda execution. If not provided, a new role will be created"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Map of environment variables for Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "source_path" {
  description = "Path to the Lambda function source code file or directory"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs for VPC configuration"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC configuration"
  type        = list(string)
  default     = []
}

variable "layers" {
  description = "List of Lambda layer ARNs to attach"
  type        = list(string)
  default     = []
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
  default     = null
}

variable "reserved_concurrent_executions" {
  description = "Number of reserved concurrent executions for the Lambda function"
  type        = number
  default     = -1
}

variable "policies" {
  description = "List of IAM policy ARNs to attach to the execution role"
  type        = list(string)
  default     = []
}

variable "log_retention_in_days" {
  description = "CloudWatch Log Group retention period in days"
  type        = number
  default     = 7
}

variable "region"  {
  type = string
}