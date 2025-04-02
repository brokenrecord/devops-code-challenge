variable "project_name" {
  description = "Base name for all resources for consistency"
  type        = string
}

variable "jwt_subject_claim" {
  type        = string
  description = "Repository specifier: repo:ORG-NAME/REPO-NAME:*"
}
