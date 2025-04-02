variable "project_name" {
  description = "Base name for all resources for consistency"
  type        = string
}

variable "elb_lb_arn_suffix" {
  description = "ARN suffix of the load balancer to display"
  type        = string
}

variable "elb_tg_arn_suffix" {
  description = "ARN suffix of the target group to display"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster to display"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service to display"
  type        = string
}

variable "rds_identifier" {
  description = "Identifier of the RDS database to display"
  type        = string
}
