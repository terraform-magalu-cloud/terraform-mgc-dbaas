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
  backup_retention_days = var.backup_enable ? var.backup_retention_days : null
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
  # datastore_id = ""
  exchange = var.exchange
  provisioner "local-exec" {
    command    = local.is_windows ? "timeout /t 60 /nobreak" : "sleep 60"
    on_failure = continue
  }
}

resource "time_sleep" "wait_5_minutes" {
  depends_on      = [mgc_dbaas_instances.this]
  count           = var.replicas_enable ? 1 : 0
  create_duration = "5m"
}

resource "mgc_dbaas_replicas" "this" {
  depends_on = [mgc_dbaas_instances.this, time_sleep.wait_5_minutes]
  # for_each   = var.replicas_enable ? local.replca_map: {}
  count     = var.replicas_enable ? var.replicas_number : 0
  name      = "${mgc_dbaas_instances.this[0].name}-rep-${count.index}"
  source_id = mgc_dbaas_instances.this[0].id
  provisioner "local-exec" {
    when       = create
    command    = local.is_windows ? "timeout /t ${count.index * 300} /nobreak" : "sleep ${count.index * 300}"
    on_failure = continue
  }
  lifecycle {
    precondition {
      condition     = mgc_dbaas_instances.this[0].status != "ERROR"
      error_message = "Status of dbaas master can't be error"
    }
  }
}

module "bastion" {
  depends_on          = [mgc_dbaas_instances.this]
  source              = "terraform-magalu-cloud/virtual-machine/mgc"
  version             = "1.2.0"
  create              = var.bastion_enable
  ssh_key_name        = length(var.bastion_ssh_key_name) > 0 ? var.bastion_ssh_key_name : "Erro, define ssh key name"
  name                = "bastion-${mgc_dbaas_instances.this[0].name}"
  associate_public_ip = true
  user_data           = <<EOF
  #!/bin/bash
  sudo apt update
  sudo apt install mysql-client postgresql-client -y
  EOF
}