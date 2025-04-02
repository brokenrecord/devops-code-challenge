variable "project_name" {
  description = "Base name for all resources for consistency"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the RDS service"
  type        = list(string)
}

variable "db_name" {
  description = "The database name"
  type        = string
}
