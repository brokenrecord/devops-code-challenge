locals {
  container_name = "app"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/${var.project_name}-logs"
  retention_in_days = 1 # Allow quick teardown*

  tags = {
    Name = "${var.project_name}-logs"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name    = local.container_name
      image   = var.image
      command = ["/app/start_app.sh"]
      portMappings = [
        { containerPort = 80 },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.aws_region
          awslogs-group         = aws_cloudwatch_log_group.log_group.name
          awslogs-stream-prefix = "${var.project_name}-service"
          mode                  = "non-blocking"
          max-buffer-size       = "5m"
        }
      }
      environment = [
        { name = "DB_HOST", value = var.db_host },
        { name = "DB_PORT", value = var.db_port },
        { name = "DB_NAME", value = var.db_name },
      ]
      secrets = [
        { name = "DB_USER", valueFrom = "${var.db_secret_arn}:username::" },
        { name = "DB_PASSWORD", valueFrom = "${var.db_secret_arn}:password::" },
      ]
    }
  ])

  tags = {
    Name = "${var.project_name}-task"
  }
}

resource "aws_ecs_service" "service" {
  name            = "${var.project_name}-service"
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = local.container_name
    container_port   = 80
  }

  tags = {
    Name = "${var.project_name}-service"
  }
}
