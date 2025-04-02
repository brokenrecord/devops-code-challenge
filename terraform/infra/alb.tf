module "alb" {
  source            = "../modules/aws/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  lb_sg_id          = module.vpc.lb_sg_id
}
