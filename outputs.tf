# -----------------------------------------------------------------------------
# Primary / Cluster Resource Identifiers
# -----------------------------------------------------------------------------
output "id" {
  description = "ID of the DBaaS instance or cluster"
  value       = local.is_cluster ? try(mgc_dbaas_clusters.this[0].id, null) : try(mgc_dbaas_instances.this[0].id, null)
}

output "name" {
  description = "Name of the DBaaS instance or cluster"
  value       = local.is_cluster ? try(mgc_dbaas_clusters.this[0].name, null) : try(mgc_dbaas_instances.this[0].name, null)
}

output "deployment_type" {
  description = "Resolved deployment topology (standalone, replicas, or cluster)"
  value       = var.deployment_type
}

output "status" {
  description = "Current status of the DBaaS resource"
  value       = local.is_cluster ? try(mgc_dbaas_clusters.this[0].status, null) : try(mgc_dbaas_instances.this[0].status, null)
}

output "current_status" {
  description = "Legacy status alias"
  value       = local.is_cluster ? try(mgc_dbaas_clusters.this[0].status, null) : try(mgc_dbaas_instances.this[0].status, null)
}

# -----------------------------------------------------------------------------
# Networking, Credentials & Connection URIs
# -----------------------------------------------------------------------------
output "user" {
  description = "Administrative user for database connection"
  value       = var.user
}

output "password" {
  description = "Administrative password (user-defined or auto-generated)"
  value       = local.effective_password
  sensitive   = true
}

output "port" {
  description = "TCP port of the database service"
  value       = local.port
}

output "host" {
  description = "Target host / database name reference"
  value       = local.host
}

output "connection_url" {
  description = "Standard connection URI string ready for application configuration"
  value       = "${local.engine_name}://${var.user}:${local.effective_password}@${local.host}:${local.port}/${local.database_name}"
  sensitive   = true
}

# -----------------------------------------------------------------------------
# Read Replicas Outputs
# -----------------------------------------------------------------------------
output "replicas" {
  description = "List of read replicas created with their details"
  value = [
    for rep in mgc_dbaas_replicas.this : {
      id     = rep.id
      name   = rep.name
      status = try(rep.status, null)
    }
  ]
}

output "replicas_id" {
  description = "List of IDs of all DBaaS replicas"
  value       = mgc_dbaas_replicas.this[*].id
}

output "replicas_name" {
  description = "List of names of all DBaaS replicas"
  value       = mgc_dbaas_replicas.this[*].name
}


