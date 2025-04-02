resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        height = 1
        width  = 24
        x      = 0
        y      = 0
        type   = "text"
        properties = {
          markdown = "# ELB-TG"
        }
      },
      {
        height = 6
        width  = 8
        x      = 0
        y      = 1
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", var.elb_tg_arn_suffix, "LoadBalancer", var.elb_lb_arn_suffix],
          ]
          period = 60
          region = "me-south-1"
          stat   = "Minimum"
          title  = "Healthy Hosts (Minimum)"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        height = 6
        width  = 8
        x      = 8
        y      = 1
        type   = "metric"

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "TargetGroup", var.elb_tg_arn_suffix, "LoadBalancer", var.elb_lb_arn_suffix],
          ]
          period = 60
          region = "me-south-1"
          stat   = "Average"
          title  = "Target Response Time"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        height = 6
        width  = 8
        x      = 16
        y      = 1
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "TargetGroup", var.elb_tg_arn_suffix, "LoadBalancer", var.elb_lb_arn_suffix],
          ]
          period = 60
          region = "me-south-1"
          stat   = "Sum"
          title  = "Requests"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        height = 1
        width  = 24
        x      = 0
        y      = 7
        type   = "text"
        properties = {
          markdown = "# ECS"
        }
      },
      {
        height = 6
        width  = 12
        x      = 0
        y      = 8
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", var.ecs_service_name, "ClusterName", var.ecs_cluster_name, { stat = "Minimum" }],
            ["...", { stat = "Maximum" }],
            ["...", { stat = "Average" }],
          ]
          period  = 300
          region  = "me-south-1"
          stacked = false
          title   = "CPU utilization"
          view    = "timeSeries"
        }
      },
      {
        height = 6
        width  = 12
        x      = 12
        y      = 8
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ServiceName", var.ecs_service_name, "ClusterName", var.ecs_cluster_name, { stat = "Minimum" }],
            ["...", { stat = "Maximum" }],
            ["...", { stat = "Average" }],
          ]
          period  = 300
          region  = "me-south-1"
          stacked = false
          title   = "Memory utilization"
          view    = "timeSeries"
        }
      },
      {
        width  = 24
        x      = 0
        y      = 14
        type   = "text"
        height = 1
        properties = {
          markdown = "# RDS"
        }
      },
      {
        height = 6
        width  = 8
        x      = 16
        y      = 15
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", var.rds_identifier],
          ]
          period = 300
          region = "me-south-1"
          stat   = "Average"
          title  = "FreeStorageSpace"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        height = 6
        width  = 8
        x      = 0
        y      = 15
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_identifier],
          ]
          period = 300
          region = "me-south-1"
          stat   = "Average"
          title  = "CPUUtilization"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
      {
        height = 6
        width  = 8
        x      = 8
        y      = 15
        type   = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", var.rds_identifier],
          ]
          period = 300
          region = "me-south-1"
          stat   = "Average"
          title  = "DatabaseConnections"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
      },
    ]
  })
}
