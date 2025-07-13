provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "redes" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ec2" {
  source           = "./modulos/maquina_virtual"
  vpc_id           = data.aws_vpc.default.id
  subnet_id        = data.aws_subnets.redes.ids[0]
  nombre_instancia = "servidor_linux"
}

module "rds" {
  source                = "./modulos/base_datos"
  ec2_security_group_id = module.ec2.security_group_id
  vpc_id                = data.aws_vpc.default.id
  nombre_bd             = "aws-test-db"
  subnet_ids            = data.aws_subnets.redes.ids
  usuario_db            = var.usuario_db
  usuario_pass          = var.usuario_pass
}