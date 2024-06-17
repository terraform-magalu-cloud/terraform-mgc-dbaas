# output "dbaas_name" {
#   description = "Name of resource"
#   value       = module.dbaas_example.name
# }

# output "password" {
#   description = "To view info, use command terraform output -raw password"
#   value       = random_string.password.id
#   sensitive   = true
# }

# output "ip_address" {
#   description = "Show IP of database"
#   value       = module.dbaas_example.ipv4
# }

# output "access" {
#   description = "Show IP of database"
#   value       = module.dbaas_example.access
# }

# output "test" {
#   value = ${for v in range(2): "replica-${v}" = v}

# }