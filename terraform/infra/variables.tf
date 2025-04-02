variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base name for all resources for consistency"
  type        = string
  default     = "devops-challenge"
}

variable "github_repo" {
  description = "Repo with Github Actions tasks"
  type        = string
}
