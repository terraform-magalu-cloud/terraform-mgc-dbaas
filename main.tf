# -----------------------------------------------------------------------------
# Random Password Generation (when not provided by user)
# -----------------------------------------------------------------------------
resource "random_password" "master_password" {
  count   = var.create && var.password == null ? 1 : 0
  length  = 24
  special = false
}

# -----------------------------------------------------------------------------
# Standalone DBaaS Instance (standalone or with replicas)
# -----------------------------------------------------------------------------
resource "mgc_dbaas_instances" "this" {
  count                 = var.create && !local.is_cluster ? 1 : 0
  name                  = var.name
  user                  = var.user
  password              = local.effective_password
  engine_name           = local.engine_name
  engine_version        = local.engine_version
  instance_type         = local.instance_type
  volume_size           = var.volume_size
  volume_type           = var.volume_type
  availability_zone     = var.availability_zone
  backup_retention_days = var.backup_enable ? var.backup_retention_days : null
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
}

# -----------------------------------------------------------------------------
# Read Replicas (for standalone topology with replicas)
# -----------------------------------------------------------------------------
resource "time_sleep" "wait_for_master" {
  count           = var.create && local.is_replicas ? 1 : 0
  depends_on      = [mgc_dbaas_instances.this]
  create_duration = var.replica_wait_duration
}

resource "mgc_dbaas_replicas" "this" {
  count      = var.create && local.is_replicas ? var.replicas_number : 0
  depends_on = [mgc_dbaas_instances.this, time_sleep.wait_for_master]
  name       = "${mgc_dbaas_instances.this[0].name}-rep-${count.index + 1}"
  source_id  = mgc_dbaas_instances.this[0].id

  lifecycle {
    precondition {
      condition     = try(mgc_dbaas_instances.this[0].status, "") != "ERROR"
      error_message = "The primary DBaaS instance status cannot be 'ERROR'."
    }
  }
}

# -----------------------------------------------------------------------------
# High Availability Database Cluster (when deployment_type = "cluster")
# -----------------------------------------------------------------------------
resource "mgc_dbaas_clusters" "this" {
  count                 = var.create && local.is_cluster ? 1 : 0
  name                  = var.name
  user                  = var.user
  password              = local.effective_password
  engine_name           = local.engine_name
  engine_version        = local.engine_version
  instance_type         = local.instance_type
  volume_size           = var.volume_size
  volume_type           = var.volume_type
  backup_retention_days = var.backup_enable ? var.backup_retention_days : null
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
}


