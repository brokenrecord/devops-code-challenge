resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.project_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-subnet-group"
  }
}

resource "aws_db_instance" "instance" {
  allocated_storage           = 20
  identifier                  = "${var.project_name}-instance"
  engine                      = "postgres"
  instance_class              = "db.t4g.micro"
  db_subnet_group_name        = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids      = var.security_group_ids
  db_name                     = var.db_name
  username                    = "challenge"
  manage_master_user_password = true # Manage the master user password via Secrets Manager
  skip_final_snapshot         = true # Allow quick teardown*

  tags = {
    Name = "${var.project_name}-instance"
  }
}
