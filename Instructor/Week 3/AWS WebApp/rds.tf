# generate the pg admin password
resource "random_password" "postgres_admin_pass" {
    length = 16
    special = false
}

# create the database subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "bradt-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "bradt-db-subnet-group"
  }
}

# create the RDS PG instance 
resource "aws_db_instance" "rds_db" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "14.2"
  instance_class       = "db.t3.micro"
  db_name                 = "restaurant"
  username             = "bradtadmin"
  password             = random_password.postgres_admin_pass.result
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.pg_defaults.id]
}

# create the security group for RDS instance
resource "aws_security_group" "pg_defaults" {
  name = "postgres-defaults"
  description = "defaults for postgres traffic"
  vpc_id = aws_vpc.vpc_main.id

  ingress {
    description      = "psql"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc_main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "postgres-defaults"
  }
}