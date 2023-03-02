
resource "aws_db_parameter_group" "mysql_parameter_group" {
  name   = "mysql-rds-pg"
  family = "mysql5.7"
}

resource "aws_db_subnet_group" "my_subnet_group" {

  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]


  tags = {
    Name = "My Database Subnet Group"
  }

}

resource "aws_db_instance" "mysql_database" {

  parameter_group_name = aws_db_parameter_group.mysql_parameter_group.name
  allocated_storage    = var.db_allocated_storage
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.engine_version
  identifier           = var.db_identifier
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  storage_type         = var.db_storage_type
  storage_encrypted    = var.db_storage_encrypted

  skip_final_snapshot = var.db_skip_final_snapshot

  #   publicly_accessible = true

  db_subnet_group_name = aws_db_subnet_group.my_subnet_group.name

  vpc_security_group_ids = [aws_security_group.database.id]

}

