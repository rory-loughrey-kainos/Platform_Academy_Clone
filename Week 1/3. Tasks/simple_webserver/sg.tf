resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    cidr_blocks = var.private_ips
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = var.private_ips
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = var.private_ips
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"    
    cidr_blocks = var.private_ips
  }
  tags = {
    Name = "webserver_sg_rl"
  }
}