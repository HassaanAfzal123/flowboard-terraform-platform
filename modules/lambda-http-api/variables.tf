variable "project_name" {
  description = "Project name prefix for resource naming"
  type        = string
}

variable "environment_name" {
  description = "Deployment environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ssm_param_prefix" {
  description = "SSM parameter prefix used by runtime"
  type        = string
}

variable "lambda_source_dir" {
  description = "Path to Lambda source directory to package"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
  default     = "handler.handler"
}

variable "lambda_memory_size" {
  description = "Lambda memory in MB"
  type        = number
  default     = 512
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
