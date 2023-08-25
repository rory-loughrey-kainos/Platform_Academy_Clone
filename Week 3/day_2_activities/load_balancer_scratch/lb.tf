resource "aws_lb" "alb" {
  name               = "alb-${var.root-name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false
  /*
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }
*/
  tags = {
    Environment = "dev"
    Name        = "alb${var.root-name}"
  }
}

resource "aws_lb_target_group" "alb_group" {
  # ...
  name     = "alb-targetg${var.root-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-rory.id
  #target_type      = "instance"
  target_type = "instance"
  health_check {
    path = "/"
    port = 80
  }

  tags = {
    Name = "alb-group${var.root-name}"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  protocol = "HTTP"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_group.arn
  }

  tags = {
    Name = "alb-listener${var.root-name}"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  count            = var.counts.instances
  target_group_arn = aws_lb_target_group.alb_group.arn
  target_id        = aws_instance.server[count.index].id
  port             = 80
}
