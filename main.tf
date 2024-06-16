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


module "bastion" {
  depends_on          = [mgc_dbaas_instances.this]
  source              = "terraform-magalu-cloud/virtual-machine/mgc"
  version             = "1.1.0"
  create              = var.bastion_enable
  ssh_key_name        = length(var.bastion_ssh_key_name) > 0 ? var.bastion_ssh_key_name : null
  name                = "bastion-${mgc_dbaas_instances.this[0].name}"
  associate_public_ip = true
  user_data = <<EOF
  #!/bin/bash
  sudo apt update
  sudo apt install mysql-client -y
  EOF
}