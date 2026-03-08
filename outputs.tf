output "engine_id" {
  description = "Unique identifier for the database engine."
  value       = var.create ? mgc_dbaas_instances.this[0].engine_id : null
}

output "id" {
  description = "Unique identifier for the DBaaS instance. Generated automatically on creation."
  value       = var.create ? mgc_dbaas_instances.this[0].id : null
}

output "instance_type_id" {
  description = "Unique identifier for the instance."
  value       = var.create ? mgc_dbaas_instances.this[0].instance_type_id : null
}

output "status" {
  description = "Status of the instance."
  value       = var.create ? mgc_dbaas_instances.this[0].status : null
}

output "parameter_group_id" {
  description = "Unique identifier for the parameters group."
  value       = var.create ? local.parameter_group[var.engine] : null
}

output "parameters_ids" {
  description = "A map of unique identifiers for the parameters, keyed by parameter name."
  value       = var.create ? (var.engine == "mysql" ? { for k, v in mgc_dbaas_parameters.mysql : k => v.id } : { for k, v in mgc_dbaas_parameters.postgresql : k => v.id }) : {}
}

output "available_engines" {
  description = "List of available database engines."
  value       = data.mgc_dbaas_engines.engines.engines
}
output "all_instance_types" {
  description = "List of available database instance type."
  value       = [for instance_tpye in data.mgc_dbaas_instance_types.all_instance_types.instance_types : instance_tpye.name]

}