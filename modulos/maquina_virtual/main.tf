variable "vpc_id" {}
variable "subnet_id" {}
variable "nombre_instancia" {}

resource "aws_security_group" "grupo_seguridad" {
  name   = var.nombre_instancia
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "servidor_linux" {
  ami                    = "ami-0150ccaf51ab55a51"
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]
  user_data              = "bash_inicio.sh"

  tags = {
    Name = var.nombre_instancia
  }
}