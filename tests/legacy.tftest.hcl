# Test backwards compatibility with legacy variables
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name     = "test-legacy"
  password = "SuperSecretPassword123!"
  engine   = "mysql-8.0"
  flavor   = "cloud-dbaas-gp1.medium"
}

run "verify_legacy_support" {
  command = plan

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_name == "mysql"
    error_message = "Legacy engine should extract mysql"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_version == "8.0"
    error_message = "Legacy engine should extract version 8.0"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].instance_type == "cloud-dbaas-gp1.medium"
    error_message = "Legacy flavor should map to instance_type"
  }
}
