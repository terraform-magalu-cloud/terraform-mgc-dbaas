output "name" {
  value = mgc_dbaas_instances.this[0].name
}

output "created_at" {
  value = mgc_dbaas_instances.this[0].created_at
}

output "started_at" {
  value = mgc_dbaas_instances.this[0].started_at
}

output "updated_at" {
  value = mgc_dbaas_instances.this[0].updated_at
}

output "id" {
  value = mgc_dbaas_instances.this[0].id
}

output "current_status" {
  value = mgc_dbaas_instances.this[0].current_status
}

output "addresses_access" {
  value = mgc_dbaas_instances.this[0].addresses[0].access
}
