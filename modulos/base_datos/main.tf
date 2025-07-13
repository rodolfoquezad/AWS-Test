variable "vpc_id" {}
variable "ec2_security_group_id" {}
variable "nombre_bd" {}
variable "subnet_ids" {}
variable "usuario_db" {}
variable "usuario_pass" {}

data "aws_subnets" "privadas" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "subnet-group-${var.nombre_bd}"
  subnet_ids = data.aws_subnets.privadas.ids
}

resource "aws_security_group" "rds" {
  name   = var.nombre_bd
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }
}

resource "aws_db_instance" "base_datos" {
  identifier             = var.nombre_bd
  username = var.usuario_db
  password = var.usuario_pass
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  skip_final_snapshot    = true
}
