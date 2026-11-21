output "id" {
  description = "Primary PostgreSQL instance ID"
  value       = module.postgres_replicas.id
}

output "name" {
  description = "Primary PostgreSQL instance name"
  value       = module.postgres_replicas.name
}

output "port" {
  description = "PostgreSQL service port (5432)"
  value       = module.postgres_replicas.port
}

output "connection_url" {
  description = "PostgreSQL primary connection URI"
  value       = module.postgres_replicas.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated database password"
  value       = module.postgres_replicas.password
  sensitive   = true
}

output "replicas_id" {
  description = "List of Read Replica IDs"
  value       = module.postgres_replicas.replicas_id
}

output "replicas_name" {
  description = "List of Read Replica names"
  value       = module.postgres_replicas.replicas_name
}
