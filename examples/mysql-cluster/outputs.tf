output "id" {
  description = "Database Cluster ID"
  value       = module.mysql_cluster.id
}

output "name" {
  description = "Database Cluster name"
  value       = module.mysql_cluster.name
}

output "port" {
  description = "Database Cluster service port (3306)"
  value       = module.mysql_cluster.port
}

output "connection_url" {
  description = "Database Cluster primary connection URI"
  value       = module.mysql_cluster.connection_url
  sensitive   = true
}

output "password" {
  description = "Auto-generated cluster master password"
  value       = module.mysql_cluster.password
  sensitive   = true
}
