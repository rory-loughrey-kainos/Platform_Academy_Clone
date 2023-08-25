# Define the security group for the Linux servers
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = aws_vpc.vpc-rory.id

  // Allow port 80 (HTTP) from anywhere
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
    cidr_blocks = var.private_subnet_cidrs
  }

  tags = {
    Name = "alb-sg${var.root-name}" //Environment = var.app_environment
  }
}

resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow incoming HTTPS connections"
  vpc_id      = aws_vpc.vpc-rory.id

  // Ingress rules to allow incoming traffic from the public subnets (ALB traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidrs
  }

  // Ingress rules to allow incoming traffic from the public subnets (ALB traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidrs
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidrs
  }

  // Allow all outgoing traffic to Internet and public subnets
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Allow all outgoing traffic
    cidr_blocks = ["0.0.0.0/0", var.public_subnet_cidrs[0], var.public_subnet_cidrs[1]]
  }

  tags = {
    Name = "ec2-sg${var.root-name}" //Environment = var.app_environment
  }
}
/*
resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow incoming connection to db from ec3"
  vpc_id      = aws_vpc.vpc-rory.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [ aws_security_group.ec2-sg.id ]
  }

  // Allow all outgoing traffic to Internet and public subnets
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Allow all outgoing traffic
    security_groups = [ aws_security_group.ec2-sg.id ]
  }
}
*/
resource "aws_security_group" "service-sg" {
  vpc_id = aws_vpc.vpc-rory.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "service-sg${var.root-name}"
  }
}

//sanity
resource "aws_security_group" "sanity-sg" {
  name        = "sanity-sg"
  description = "Allow incoming SSH connections"
  vpc_id      = aws_vpc.vpc-rory.id

  // Allow port 80 (HTTP) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Allow all Port 80 traffic to the private subnets containing the EC2 instances
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg${var.root-name}" //Environment = var.app_environment
  }
}