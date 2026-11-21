provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "mysql" {
  source          = "../../"
  name            = "mysql-standalone-example"
  deployment_type = "standalone"
  engine_name     = "mysql"
  engine_version  = "8.4"
  instance_type   = "DP2-8-40"
  user            = "admin"
  database_name   = "appdb"
  volume_size     = 20
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
}
