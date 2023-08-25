resource "aws_lb" "app_lb" {
  name                       = "alb-rory"
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = [for subnet in aws_subnet.public_subnet : subnet.id]
  enable_deletion_protection = true
  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "log"
    enabled = true
  }
  tags = {
    name        = "alb-rory"
    Environment = "Dev"
  }
}

resource "aws_lb_target_group" "lb_ec2_target" {
  name     = "alb-ec2-target-group-rory"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path = "/index"
    port              = 80
  }
}

resource "aws_lb_target_group_attachment" "lb_ec2_target_attach" {
  count            = var.counts.ec2
  target_group_arn = aws_lb_target_group.lb_ec2_target.arn
  target_id        = aws_instance.server[count.index].id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_ec2_target.arn
  }
}

//nlb
/*
resource "aws_lb" "nlb" {
  name                       = "nlb-rory"
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = [for subnet in aws_subnet.private_subnet : subnet.id]
  enable_deletion_protection = true
  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "log"
    enabled = true
  }

  tags = {
    name        = "alb-rory"
    Environment = "Dev"
  }
}
*/


