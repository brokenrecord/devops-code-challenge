module "alb" {
  source            = "../modules/aws/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  lb_sg_id          = module.vpc.lb_sg_id
}