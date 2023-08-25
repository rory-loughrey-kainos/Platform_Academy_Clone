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
    name = "lamp-server-sg-rory"
  }
}

resource "aws_security_group" "db_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]

  }


  tags = {
    name = "db-instance-rory-sg"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr


  tags = {
    Name = "vpc-rory"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vpc-gateway-rory"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id

  count = var.subnet_count.public

  cidr_block = var.public_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-subnet-rory-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id

  count = var.subnet_count.private

  cidr_block = var.private_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-rory-${count.index}"
  }
}
resource "aws_route_table_association" "public_rt_asso" {
  count          = var.subnet_count.public
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "private-rt-rory"
  }
}
resource "aws_route_table_association" "private_rt_asso" {
  count          = var.subnet_count.private
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_eip_association" "eip_assoc" {
  count         = 1
  instance_id   = aws_instance.app_server[count.index].id
  allocation_id = aws_eip.eip[count.index].id
}
resource "aws_eip" "eip" {
  count    = 1
  instance = aws_instance.app_server[count.index].id
  vpc = true

  depends_on = [ aws_internet_gateway.gateway ]
  tags = {
    Name = "rl_EC2_eip"
  }
}