output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}