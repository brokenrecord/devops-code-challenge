module "iam" {
  source       = "../modules/aws/iam"
  project_name = var.project_name
}

module "github_iam" {
  source            = "../modules/aws/github_iam"
  project_name      = var.project_name
  jwt_subject_claim = "repo:${var.github_repo}:*"
}
