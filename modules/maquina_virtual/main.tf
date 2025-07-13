#Declaramos proveedor y region, estoy usando la default
provider "aws" {
  region = "us-east-1"
}

#Uso de VPC, usare la vpc por defecto por simplicidad
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "red_publica" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

#Uso de un Grupo de Seguridad para permitir conexiones

resource "aws_security_group" "grupo_seguridad" {
  name   = "grupo_seguridad"
  vpc_id = data.aws_vpc.default.id

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTPS
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #SSH
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

#Creacion de clave ssh para poder conectarse a la instancia
resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_iam_role" "rol_ec2" {
  name = "ec2-ecr-rol"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "leer_ecr" {
  role       = aws_iam_role.rol_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "perfil_ecr" {
  name = "ec2-ecr-profile"
  role = aws_iam_role.rol_ec2.name
}

#Creacion de EC2 
resource "aws_instance" "servidor_linux" {
  ami                    = "ami-0150ccaf51ab55a51"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.red_publica.ids[0]
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]
  key_name               = "ssh-key"
  iam_instance_profile   = aws_iam_instance_profile.perfil_ecr.name
  user_data              = file("bash_inicio.sh")

  tags = {
    Name = "Servidor_Linux"
  }
}


