variable "project_name" {
  description = "Base name for all resources for consistency"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the lb target group for the ECS service"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster for the ECS service"
  type        = string
}

variable "execution_role_arn" {
  description = "Name of the ECS task execution IAM role"
  type        = string
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = number
}

variable "memory" {
  description = "Memory for the ECS task (in MB)"
  type        = number
}

variable "image" {
  description = "Image for the ECS task"
  type        = string
}

variable "db_host" {
  description = "The database hostname"
  type        = string
}

variable "db_port" {
  description = "The database port"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_secret_arn" {
  description = "The ARN of the secret containing the master user password"
  type        = string
}
