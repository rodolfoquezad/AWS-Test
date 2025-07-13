variable "usuario_db" {
  description = "Usuario de PostgreSQL"
  type        = string
  sensitive   = true
}

variable "usuario_pass" {
  description = "Contraseña de PostgreSQL"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Región de AWS"
  default     = "us-east-1"
}
