module "ecs" {
  source             = "../modules/aws/ecs"
  project_name       = var.project_name
  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.app_sg_id]
  target_group_arn   = module.alb.target_group_arn
  cluster_arn        = module.ecs.cluster_name
  execution_role_arn = module.iam.execution_role_arn
  cpu                = 256
  memory             = 512
  image              = "${module.ecr.repository_url}:latest"
  db_host            = module.rds.address
  db_port            = module.rds.port
  db_name            = module.rds.db_name
  db_secret_arn      = module.rds.secret_arn
}
