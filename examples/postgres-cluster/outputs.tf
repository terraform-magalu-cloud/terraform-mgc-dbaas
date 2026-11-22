output "id" {
  description = "Database Cluster ID"
  value       = module.postgres_cluster.id
}

output "name" {
  description = "Database Cluster name"
  value       = module.postgres_cluster.name
}

output "port" {
  description = "Database Cluster service port (5432)"
  value       = module.postgres_cluster.port
}

output "connection_url" {
  description = "Database Cluster primary connection URI"
  value       = module.postgres_cluster.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated cluster master password"
  value       = module.postgres_cluster.password
  sensitive   = true
}
