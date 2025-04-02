module "vpc" {
  source       = "../modules/aws/vpc"
  project_name = var.project_name
}
