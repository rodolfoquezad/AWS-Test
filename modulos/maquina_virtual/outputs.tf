output "ip_publica" {
  description = "IP pública de la instancia"
  value       = aws_instance.servidor_linux.public_ip
}

output "url_apache" {
  description = "URL para hola mundo"
  value       = "http://${aws_instance.servidor_linux.public_ip}"
}

output "url_vscode" {
  description = "URL de VS Code Server"
  value       = "http://${aws_instance.servidor_linux.public_ip}:8080"
}

output "security_group_id" {
  description = "ID del Security Group de la EC2"
  value       = aws_security_group.grupo_seguridad.id
}