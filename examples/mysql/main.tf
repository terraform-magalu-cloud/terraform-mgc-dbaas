provider "mgc" {
  region  = "br-se1"
  api_key = var.api_key
}


resource "random_string" "sufix" {
  length  = 6
  special = false
}

resource "random_string" "sufix_name" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 8
  special = false
}

module "dbaas_mysql" {
  source                = "../../"
  name                  = "db-${random_string.sufix_name.id}-msql"
  user                  = "admin"
  password              = random_string.password.id
  replicas_enable       = true
  replicas_number       = 2
  engine_version        = "8.0"
  instance_type         = "DP2-8-40"
  engine                = "mysql"
  volume_size           = 30
  backup_retention_days = 30
  backup_start_at       = "02:00:00"
  backup_enable         = true
  bastion_enable        = true
  bastion_ssh_key_name  = "key-example"
}

module "dbaas_postgresql" {
  source                = "../../"
  name                  = "db-${random_string.sufix_name.id}-pgsql"
  user                  = "admin"
  password              = random_string.password.id
  replicas_enable       = true
  replicas_number       = 2
  engine_version        = "16"
  engine                = "postgresql"
  instance_type         = "DP2-8-40"
  volume_size           = 30
  backup_retention_days = 30
  backup_start_at       = "02:00:00"
  backup_enable         = true
  bastion_enable        = true
  bastion_ssh_key_name  = "key-example"
}