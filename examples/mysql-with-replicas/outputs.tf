output "id" {
  description = "Primary Database ID"
  value       = module.mysql_replicas.id
}

output "name" {
  description = "Primary Database name"
  value       = module.mysql_replicas.name
}

output "connection_url" {
  description = "Database connection URI"
  value       = module.mysql_replicas.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated admin password"
  value       = module.mysql_replicas.password
  sensitive   = true
}

output "replicas_id" {
  description = "List of Read Replica IDs"
  value       = module.mysql_replicas.replicas_id
}

output "replicas_name" {
  description = "List of Read Replica names"
  value       = module.mysql_replicas.replicas_name
}
