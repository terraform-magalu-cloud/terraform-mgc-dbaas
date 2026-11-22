output "id" {
  description = "PostgreSQL Database ID"
  value       = module.postgres.id
}

output "name" {
  description = "PostgreSQL Database name"
  value       = module.postgres.name
}

output "port" {
  description = "PostgreSQL service port (5432)"
  value       = module.postgres.port
}

output "connection_url" {
  description = "PostgreSQL connection URI (e.g. postgresql://user:pass@host:5432/db)"
  value       = module.postgres.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated database password"
  value       = module.postgres.password
  sensitive   = true
}
