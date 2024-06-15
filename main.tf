resource "mgc_dbaas_instances" "this" {
  count     = var.create ? 1 : 0
  flavor_id = local.flavor[var.flavor]
  name      = var.name
  user      = var.user
  password  = var.password
  volume = {
    size = var.volume_size
    type = var.volume_type
  }
  engine_id             = local.engine[var.engine]
  backup_retention_days = var.backup_enable ? var.backup_retention_days : 0
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
  # datastore_id = ""
  # engine_id = ""
  exchange = var.exchange
  # status = ""
}
resource "mgc_dbaas_replicas" "this" {
  count     = var.replicas_enable ? var.replicas_num_hosts : 0
  name      = "${mgc_dbaas_instances.this[0].name}-${count.index}"
  source_id = mgc_dbaas_instances.this[0].id
}
