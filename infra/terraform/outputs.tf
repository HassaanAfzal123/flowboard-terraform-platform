output "api_url" {
  description = "HTTP API invoke URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.api.function_name
}

output "stack_environment" {
  description = "Terraform environment name"
  value       = var.environment_name
}
