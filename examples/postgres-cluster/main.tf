provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "postgres_cluster" {
  source          = "../../"
  name            = "postgres-cluster-example"
  deployment_type = "cluster"
  engine_name     = "postgresql"
  engine_version  = "16"
  instance_type   = "DP2-8-40"
  user            = "admin"
  database_name   = "production_db"
  volume_size     = 50
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
}
