module "cloudwatch" {
  source            = "../modules/aws/cloudwatch"
  project_name      = var.project_name
  elb_lb_arn_suffix = module.alb.arn_suffix
  elb_tg_arn_suffix = module.alb.target_group_arn_suffix
  ecs_cluster_name  = module.ecs.cluster_name
  ecs_service_name  = module.ecs.service_name
  rds_identifier    = module.rds.identifier
}
