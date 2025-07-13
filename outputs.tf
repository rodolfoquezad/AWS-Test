output "ip_publica_instancia" {
  value = module.ec2.ip_publica
}

output "url_apache" {
  value = "http://${module.ec2.ip_publica}"
}

output "url_vscode" {
  value = "http://${module.ec2.ip_publica}:8080"
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_id" {
  value = module.rds.db_id
}