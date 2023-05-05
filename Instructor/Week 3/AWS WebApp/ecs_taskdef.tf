resource "aws_ecs_task_definition" "service" {
  family             = "tomo-restaurants"
  task_role_arn      = "arn:aws:iam::310458589822:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::310458589822:role/tomo-ECS-Task-Role"
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 512
  memory = 1024
  
  container_definitions = jsonencode([
    {
      name                     = "restaurants"
      image                    = "310458589822.dkr.ecr.${var.aws_region}.amazonaws.com/django-multicloud-tomo:latest"
 
      essential                = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
      environment = [
          { 
              "name" : "CLOUD",
              "value": "AWS"
          },
          {
              "name": "DEBUG",
              "value": "False"
          },
          {
              "name": "WEBSITE_HOSTNAME",
              "value": aws_route53_record.alb_cname.fqdn

          },
          { 
              "name" : "DBHOST",
              "value": aws_db_instance.rds_db.address
          },
          
          { 
              "name" : "DBNAME",
              "value": aws_db_instance.rds_db.db_name
          },
          
          { 
              "name" : "DBUSER",
              "value": aws_db_instance.rds_db.username
          },
          
          { 
              "name" : "DBPASS",
              "value": random_password.postgres_admin_pass.result
          }
      ]
      logConfiguration = {
          logDriver = "awslogs"
          options = {
              awslogs-group = aws_cloudwatch_log_group.fargate_logs.name
              awslogs-region = var.aws_region
              awslogs-stream-prefix = "restaurants"
          }
      }
      }  
  ])
}

resource "aws_cloudwatch_log_group" "fargate_logs" {
    name = "tomo_fargate_logs"
    retention_in_days = 30
}