module "flowboard_api" {
  source = "../../modules/lambda-http-api"

  project_name      = var.project_name
  environment_name  = var.environment_name
  aws_region        = var.aws_region
  ssm_param_prefix  = var.ssm_param_prefix
  lambda_source_dir = "${path.root}/../../lambda/src"

  tags = {
    owner = "hassaan"
    track = "terraform-portfolio"
  }
}
