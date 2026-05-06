locals {
  name_prefix = "${var.project_name}-${var.environment_name}"
  lambda_name = "${var.project_name}-api-${var.environment_name}"

  common_tags = merge(
    {
      project     = var.project_name
      environment = var.environment_name
      managed_by  = "terraform"
    },
    var.tags
  )
}
