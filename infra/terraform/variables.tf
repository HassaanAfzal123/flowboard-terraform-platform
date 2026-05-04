variable "aws_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
}

variable "environment_name" {
  description = "Deployment environment name"
  type        = string
}

variable "project_name" {
  description = "Project name prefix for resource naming"
  type        = string
  default     = "flowboard"
}

variable "ssm_param_prefix" {
  description = "SSM path prefix for runtime secrets"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 512
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
