resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow incoming HTTPS connections"
  vpc_id      = var.vpc_id

  // Ingress rules to allow incoming traffic from the public subnets (ALB traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.public_subnets
  }

  // Ingress rules to allow incoming traffic from the public subnets (ALB traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_subnets
  }

  // Allow all outgoing traffic to Internet and public subnets
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Allow all outgoing traffic
    cidr_blocks = concat(["0.0.0.0/0"],var.public_subnets)
  }

  tags = {
    Name = "${local.naming_prefix}-ec2-sg" //Environment = var.app_environment
  }
}

# Define the security group for the Linux servers
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow incoming HTTPS connections"
  vpc_id      = var.vpc_id

  // Allow port 80 (HTTPS) from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic from anywhere
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" // Allow all Port 80 traffic to the private subnets containing the EC2 instances
    cidr_blocks = var.private_subnets
  }

  tags = {
    Name = "${local.naming_prefix}alb-sg" //Environment = var.app_environment
  }
}