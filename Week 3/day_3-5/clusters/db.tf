
resource "aws_db_instance" "postgres" {
  db_name              = "dbrory"
  identifier           = "db-instance${var.root-name}"
  engine               = "postgres"
  engine_version       = "14.6"
  db_subnet_group_name = aws_db_subnet_group.postgres_group.name

  instance_class = "db.t3.micro"

  storage_type            = "gp2"
  allocated_storage       = 20
  storage_encrypted       = true
  backup_retention_period = 0
  skip_final_snapshot     = true
  //final_snapshot_identifier = "db-defunct-rory"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  username = "awsuser"
  password = var.db_password

  depends_on = [aws_security_group.ec2-sg]

  tags = {
    name = "postgres${var.root-name}"
  }
}

resource "aws_db_subnet_group" "postgres_group" {
  name       = "db-subnet-group${var.root-name}"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name = "db-subnet-group${var.root-name}"
  }
}


