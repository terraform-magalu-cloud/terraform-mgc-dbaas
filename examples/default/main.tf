provider "mgc" {
  api_key = var.api_key
  region  = var.region
}

resource "random_string" "sufix_name" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 8
  special = false
}

module "dbaas_example_ne" {
  source               = "../../"
  name                  = var.name
  user                  = var.user
  password              = var.password
  engine                = var.engine
  engine_version        = var.engine_version
  instance_type         = var.instance_type
  volume_size           = var.volume_size
  volume_type           = var.volume_type
  backup_retention_days = var.backup_retention_days
  backup_start_at       = var.backup_start_at
  bastion_enable       = true
  bastion_ssh_key_name = var.ssh_key_name
}