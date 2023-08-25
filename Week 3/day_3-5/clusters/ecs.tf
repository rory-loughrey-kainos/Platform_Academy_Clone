resource "aws_kms_key" "ecs_key" {
  description             = "key for ecs cluster rory "
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "ecs_cloudwatch_group" {
  name = "ecs-logs${var.root-name}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "db-ecs-cluster${var.root-name}"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_cloudwatch_group.name
      }
    }
  }
}

resource "aws_ecs_service" "docker" {
  name                 = "docker-service${var.root-name}"
  cluster              = aws_ecs_cluster.cluster.id
  task_definition      = aws_ecs_task_definition.definition.arn
  launch_type          = "FARGATE"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = [aws_subnet.private[0].id]
    assign_public_ip = false

    security_groups = [aws_security_group.alb-sg.id, aws_security_group.service-sg.id]
  }
  /*
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_ecs_group.arn
    container_name   = "docker"
    container_port   = 8080
  }
*/
}

resource "aws_ecs_task_definition" "definition" {
  family                   = "task-definition${var.root-name}"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name = "docker"
      "image" : "mcr.microsoft.com/windows/servercore/iis",
      "cpu" : 1024,
      "memory" : 2048,
      "essential" : true
      port = 8080
    }
  ])

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}