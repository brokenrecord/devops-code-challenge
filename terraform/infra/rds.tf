module "rds" {
  source             = "../modules/aws/rds"
  project_name       = var.project_name
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.app_sg_id]
  db_name            = "app"
}
