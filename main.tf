resource "mgc_dbaas_instances" "this" {
  count                 = var.create ? 1 : 0
  name                  = var.name
  user                  = var.user
  password              = var.password
  engine_name           = var.engine
  engine_version        = var.engine_version
  instance_type         = var.instance_type
  volume_size           = var.volume_size
  backup_retention_days = var.backup_enable ? var.backup_retention_days : null
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
  parameter_group       = var.create_parameter_group ? local.parameter_group[var.engine] : null
  depends_on            = [mgc_dbaas_parameters.postgresql, mgc_dbaas_parameters.mysql]

  lifecycle {
    precondition {
      # A condição verifica se a engine/versão desejada existe na lista de engines ativas
      condition = length([
        for engine in data.mgc_dbaas_engines.engines.engines : engine
        if engine.name == var.engine && engine.version == var.engine_version
      ]) > 0

      error_message = "The specified database engine/version combination is not available or active. Engine: '${var.engine}', Version: '${var.engine_version}'. Please check the available engines in Magalu Cloud."
    }

    precondition {
      condition     = contains([for type in data.mgc_dbaas_instance_types.all_instance_types.instance_types : type.name], var.instance_type)
      error_message = "The selected instance_type '${var.instance_type}' is not a valid or available type. Please choose one of the following: ${join(", ", [for type in data.mgc_dbaas_instance_types.all_instance_types.instance_types : type.name])}."
    }

    precondition {
      condition     = contains(local.allowed_dp_instance_types, var.instance_type)
      error_message = "The selected instance_type '${var.instance_type}' is not a valid or available type. Please choose one of the following: ${join(", ", [for type in data.mgc_dbaas_instance_types.all_instance_types.instance_types : type.name])}."
    }
  }

  provisioner "local-exec" {
    command    = local.is_windows ? "timeout /t 60 /nobreak" : "sleep 60"
    on_failure = continue
  }

}

/* resource "mgc_dbaas_clusters" "this" {
  count                 = var.create ? 1 : 0
  name                  = var.name
  user                  = var.user
  password              = var.password
  engine_name           = var.engine
  engine_version        = var.engine_version
  instance_type         = var.instance_type
  volume_size           = var.volume_size
  backup_retention_days = var.backup_enable ? var.backup_retention_days : null
  backup_start_at       = var.backup_enable ? var.backup_start_at : null
  parameter_group       = var.create_parameter_group ? local.parameter_group[var.engine] : null
  depends_on            = [mgc_dbaas_parameters.postgresql, mgc_dbaas_parameters.mysql]


    lifecycle {
    precondition {
      # A condição verifica se a engine/versão desejada existe na lista de engines ativas
      condition = length([
        for engine in data.mgc_dbaas_engines.engines.engines : engine
        if engine.name == var.engine && engine.version == var.engine_version
      ]) > 0

      error_message = "The specified database engine/version combination is not available or active. Engine: '${var.engine}', Version: '${var.engine_version}'. Please check the available engines in Magalu Cloud."
    }

    precondition {
      condition = contains(local.allowed_dp_instance_types, var.instance_type)
      error_message = "The selected instance_type '${var.instance_type}' is not a valid or available type. Please choose one of the following: ${join(", ", [for type in data.mgc_dbaas_instance_types.all_instance_types.instance_types : type.name])}."
    }
  }

  provisioner "local-exec" {
    command    = local.is_windows ? "timeout /t 60 /nobreak" : "sleep 60"
    on_failure = continue
  }
} */

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
  depends_on   = [mgc_dbaas_instances.this]
  count        = var.bastion_enable ? 1 : 0
  source       = "terraform-magalu-cloud/virtual-machine/mgc"
  create       = var.bastion_enable
  ssh_key_name = length(var.bastion_ssh_key_name) > 0 ? var.bastion_ssh_key_name : "Erro, define ssh key name"
  name         = "bastion-${mgc_dbaas_instances.this[0].name}"
  user_data    = <<EOF
  #!/bin/bash
  sudo apt update
  sudo apt install mysql-client postgresql-client -y
  EOF
}
