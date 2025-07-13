output "ip_publica_instancia" {
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