variable "aws_region" {
  description = "AWS region for this example"
  type        = string
  default     = "ap-south-1"
}

variable "environment_name" {
  description = "Environment name for resource naming"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "flowboard"
}

variable "ssm_param_prefix" {
  description = "SSM runtime prefix used by Lambda"
  type        = string
  default     = "/flowboard/dev"
}
