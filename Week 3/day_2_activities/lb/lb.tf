resource "aws_lb" "app_lb" {
  name               = "alb-rory"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for subnet in aws_subnet.private_subnet : subnet.id]
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "lb-rory"
    enabled = true
  }

  tags = {
    name = "alb-rory"
    Environment = "Dev"
  }
}