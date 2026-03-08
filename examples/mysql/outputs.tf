output "instance_type" {
  description = "Type of instance database"
  value       = module.dbaas_mysql.all_instance_types
}