provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "mysql_replicas" {
  source          = "../../"
  name            = "mysql-replicas-example"
  deployment_type = "replicas"
  engine_name     = "mysql"
  engine_version  = "8.0"
  instance_type   = "DP2-8-40"
  user            = "admin"
  database_name   = "ecommerce"
  volume_size     = 30
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
  replicas_number = 2
}
