provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "postgres" {
  source          = "../../"
  name            = "postgres-standalone-example"
  deployment_type = "standalone"
  engine_name     = "postgresql"
  engine_version  = "15"
  instance_type   = "DP2-8-40"
  user            = "dbuser"
  database_name   = "analytics"
  volume_size     = 20
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
}
