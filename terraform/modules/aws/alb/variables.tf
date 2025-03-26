variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "lb_sg_id" {
  description = "Security group ID for ALB"
  type        = string
}