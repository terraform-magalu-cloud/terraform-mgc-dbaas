output "dbaas_name" {
  value = module.dbaas-example.name
}

output "password" {
  description = "To view info, use command terraform output -raw password"
  value       = random_string.password.id
  sensitive   = true
}