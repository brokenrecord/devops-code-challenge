module "ecr" {
  source       = "../modules/aws/ecr"
  project_name = var.project_name
  name         = "app"
}
