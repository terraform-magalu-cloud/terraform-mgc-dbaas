output "id" {
  description = "Database ID"
  value       = module.mysql.id
}

output "name" {
  description = "Database name"
  value       = module.mysql.name
}

output "port" {
  description = "Database service port"
  value       = module.mysql.port
}

output "connection_url" {
  description = "Database connection URI"
  value       = module.mysql.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated admin password"
  value       = module.mysql.password
  sensitive   = true
}
