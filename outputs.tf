output "name" {
  description = "Name of resource"
  value       = mgc_dbaas_instances.this[0].name
}

output "created_at" {
  description = "Timstamp when this resource was created"
  value       = mgc_dbaas_instances.this[0].created_at
}

output "started_at" {
  description = "Timstamp when this resource was started last time"
  value       = mgc_dbaas_instances.this[0].started_at
}

output "updated_at" {
  description = "Timstamp when this resource was updated last time"
  value       = mgc_dbaas_instances.this[0].updated_at
}

output "id" {
  description = "Id of resource"
  value       = mgc_dbaas_instances.this[0].id
}

output "current_status" {
  description = "Current status this resource"
  value       = mgc_dbaas_instances.this[0].current_status
}

output "ipv4" {
  description = "IP this resource, format IPv4"
  value       = mgc_dbaas_instances.this[0].addresses[0].address
  sensitive   = false
}

output "access" {
  description = "Type access this resource, format PRIVATE or PUBLIC"
  value       = mgc_dbaas_instances.this[0].addresses[0].access
  sensitive   = false
}

output "replicas_id" {
  description = "TId this resources"
  value       = mgc_dbaas_replicas.this[*].id
  sensitive   = false
}

output "replicas_name" {
  description = "Name this resources"
  value       = mgc_dbaas_replicas.this[*].name
  sensitive   = false
}

output "replicas_access" {
  description = "Type access this resources, format PRIVATE or PUBLIC"
  value       = mgc_dbaas_replicas.this[*].addresses[0].access
  sensitive   = false
}

output "replicas_addresses" {
  description = "Address this resources"
  value       = mgc_dbaas_replicas.this[*].addresses[0].address
  sensitive   = false
}