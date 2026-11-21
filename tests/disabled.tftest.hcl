# Test behavior when create = false
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  create   = false
  name     = "test-dbaas-disabled"
  password = "SuperSecretPassword123!"
}

run "verify_create_false" {
  command = plan

  assert {
    condition     = length(mgc_dbaas_instances.this) == 0
    error_message = "No instance should be created when create = false"
  }

  assert {
    condition     = length(mgc_dbaas_replicas.this) == 0
    error_message = "No replicas should be created when create = false"
  }



  assert {
    condition     = output.id == null
    error_message = "Output id should be null when create = false"
  }

  assert {
    condition     = output.name == null
    error_message = "Output name should be null when create = false"
  }


}
