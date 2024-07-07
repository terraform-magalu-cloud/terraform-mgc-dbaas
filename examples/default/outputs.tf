output "dbaas_name" {
  description = "Name of resource"
  value       = module.dbaas_example_ne.name
}

output "password" {
  description = "To view info, use command terraform output -raw password"
  value       = random_string.password.id
  sensitive   = true
}

output "ip_address" {
  description = "Show IP of database"
  value       = module.dbaas_example_ne.ipv4
}

output "access" {
  description = "Show IP of database"
  value       = module.dbaas_example_ne.access
}

output "replicas_id" {
  description = "Show IP of database"
  value       = module.dbaas_example_ne.replicas_id
}

output "replicas_addresses" {
  description = "Show IP of database"
  value       = module.dbaas_example_ne.replicas_addresses
}

output "replicas_name" {
  description = "Show IP of database"
  value       = module.dbaas_example_ne.replicas_name
}