output "dbaas_name" {
  value = module.dbaas-example.name
}

output "password" {
  description = "To view info, use command terraform output -raw password"
  value       = random_string.password.id
  sensitive   = true
}

output "ip_address" {
  description = "Show IP of database"
  value       = module.dbaas-example.ipv4
}

output "access" {
  description = "Show IP of database"
  value       = module.dbaas-example.access
}