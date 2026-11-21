provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "postgres_replicas" {
  source          = "../../"
  name            = "postgres-replicas-example"
  deployment_type = "replicas"
  engine_name     = "postgresql"
  engine_version  = "16"
  instance_type   = "DP2-8-40"
  user            = "dbadmin"
  database_name   = "production"
  volume_size     = 50
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
  replicas_number = 2
}
