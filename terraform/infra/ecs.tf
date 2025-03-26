module "ecs" {
  source              = "../modules/aws/ecs"
  vpc_id              = module.vpc.vpc_id
}