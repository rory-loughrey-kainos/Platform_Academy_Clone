
resource "aws_db_instance" "mysql" {
  db_name              = "sample"
  identifier           = "db-instance-rory"
  engine               = "mysql"
  engine_version       = "5.7"
  db_subnet_group_name = aws_db_subnet_group.mysql_group.name

  instance_class = "db.t3.micro"

  storage_type              = "gp2"
  allocated_storage         = 20
  storage_encrypted         = true
  backup_retention_period   = 0
  skip_final_snapshot = true
  //final_snapshot_identifier = "db-defunct-rory"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  username = "awsuser"
  password = var.db_password

  tags = {
    name = "lamp-server-db-rory"
  }
}

resource "aws_db_subnet_group" "mysql_group" {
  name       = "db-subnetg-rory"
  subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]

  tags = {
    Name = "db subnet group - rory"
  }
}