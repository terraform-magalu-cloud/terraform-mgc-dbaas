provider "mgc" {
  region  = var.region
  api_key = var.api_key
}

module "mysql_cluster" {
  source          = "../../"
  name            = "mysql-cluster-example"
  deployment_type = "cluster"
  engine_name     = "mysql"
  engine_version  = "8.0"
  instance_type   = "DP2-8-40"
  user            = "admin"
  database_name   = "production_db"
  volume_size     = 50
  volume_type     = "CLOUD_NVME15K"
  backup_enable   = true
}
