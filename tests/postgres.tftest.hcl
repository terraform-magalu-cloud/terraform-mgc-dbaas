# Test PostgreSQL configuration
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name           = "test-dbaas-postgres"
  password       = "SuperSecretPassword123!"
  engine_name    = "postgresql"
  engine_version = "16"
  instance_type  = "DP2-16-40"
  volume_size    = 50
  volume_type    = "CLOUD_NVME20K"
}

run "verify_postgres" {
  command = plan

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_name == "postgresql"
    error_message = "Engine name should be postgresql"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_version == "16"
    error_message = "Engine version should be 16"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].instance_type == "DP2-16-40"
    error_message = "Instance type should be DP2-16-40"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].volume_size == 50
    error_message = "Volume size should be 50"
  }
}
