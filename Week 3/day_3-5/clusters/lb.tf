resource "aws_lb" "alb" {
  name               = "alb${var.root-name}"
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


//ec2
resource "aws_lb_target_group" "alb_ec2_group" {
  # ...
  name     = "alb-target-ec2${var.root-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-rory.id
  //target_type = "instance"

  health_check {
    path                = "/"
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
  }

  tags = {
    Name = "alb-ec2-group${var.root-name}"
  }
}

resource "aws_lb_listener" "alb_ec2_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.alb_cert.arn
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_group.arn
  }

  tags = {
    Name = "alb-listener${var.root-name}"
  }

  depends_on = [aws_acm_certificate_validation.verify_alb_cert]
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  count            = var.counts.instances
  target_group_arn = aws_lb_target_group.alb_ec2_group.arn
  target_id        = local.web_instance_ids[count.index]
}

//containers
resource "aws_lb_target_group" "alb_ecs_group" {
  # ...
  depends_on = [aws_lb.alb]
  name       = "alb-target-ecs${var.root-name}"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc-rory.id
  #target_type      = "instance"

  health_check {
    path                = "/"
    port                = 80
    interval            = 20
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 10
  }

  tags = {
    Name = "alb-ecs-group${var.root-name}"
  }
}
/*
resource "aws_lb_listener" "alb_ecs_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  protocol = "HTTP"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ecs_group.arn
  }

  tags = {
    Name = "alb-listener${var.root-name}"
  }
}
*/

