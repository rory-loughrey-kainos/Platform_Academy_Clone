# create security group for port 8000
resource "aws_security_group" "ecs_8000" {
  name        = "ecs_8000"
  description = "allow 8000 inbound"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description      = "8000 from vpc"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc_main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ecs_8000"
  }
}

# creare the service in ECS
resource "aws_ecs_service" "restaurant_svc" {
    name = "restaurant-svc"
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.service.arn
    desired_count = 1
    
    health_check_grace_period_seconds = 300 # bastard thing.
    launch_type = "FARGATE"
    platform_version = "LATEST"
    force_new_deployment = true
    
    load_balancer {
      target_group_arn = aws_lb_target_group.alb_tgroup.id
      container_name = "restaurants" #must match container definition
      container_port = 8000
    }
    network_configuration {
      subnets = [aws_subnet.private_a.id, aws_subnet.private_b.id]
      security_groups = [aws_security_group.ecs_8000.id]

    }  
}