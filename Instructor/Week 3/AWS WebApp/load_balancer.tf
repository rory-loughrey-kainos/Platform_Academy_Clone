# Create the Load Balancer and define/attach the security group
resource "aws_lb" "alb_main" {
    name = "bradt-loadbalancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_80_443.id ]
    subnets = [ 
        aws_subnet.public_a.id, 
        aws_subnet.public_b.id 
        ]  
}
resource "aws_security_group" "alb_80_443" {
  name        = "alb_80_443"
  description = "allow incoming http/https traffic 80/443"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description      = "443 all"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "80 all"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb_80_443"
  }
}

# set redirect from 80 to 443/HTTPS
resource "aws_lb_listener" "http_redirect" {
    load_balancer_arn = aws_lb.alb_main.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "redirect"
      redirect {
          port = "443"
          protocol = "HTTPS"
          status_code = "HTTP_301"
      }
    }  
}

# create target group for load balancer
resource "aws_lb_target_group" "alb_tgroup" {
    name = "bradt-alb-tgroup"
    port = 8000
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = aws_vpc.vpc_main.id
}

# set listener to forward 443 traffic to the load balancer target group
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb_main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  # set our certificate on https listener
  certificate_arn   = aws_acm_certificate.alb_cert.arn

  # forward
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tgroup.arn
  }
}