# Terraform outputs specifically used by the GitHub Actions workflow to deploy
# the application to AWS ECS. Ref: `.github/workflows/deploy.yml`

output "__gha_aws_region" {
  description = "AWS region used by the GitHub Actions workflow"
  value       = var.aws_region
}

output "__gha_ecr_repository" {
  description = "ECR repo used by the GitHub Actions workflow"
  value       = module.ecr.name
}

output "__gha_ecs_cluster" {
  description = "ECS cluster used by the GitHub Actions workflow"
  value       = module.ecs.cluster_name
}

output "__gha_ecs_service" {
  description = "ECS service used by the GitHub Actions workflow"
  value       = module.ecs.service_name
}

output "__gha_gha_role_arn" {
  description = "IAM role ARN assumed by the GitHub Actions workflow"
  value       = module.github_iam.role_arn
}

output "url" {
  description = "URL of the deployed application"
  value       = "http://${module.alb.dns_name}/"
}

output "url_dashboard" {
  description = "URL of the cloudwatch dashboard"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards/dashboard/${module.cloudwatch.dashboard_name}"
}
