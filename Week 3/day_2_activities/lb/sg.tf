resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = var.trusted_ips
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = var.trusted_ips
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "alb-sg-rory"
  }
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = var.trusted_ips
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = var.trusted_ips
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "ec2-sg-rory"
  }
}
