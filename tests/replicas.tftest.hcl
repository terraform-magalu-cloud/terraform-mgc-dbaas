# Test Read Replicas configuration
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name            = "test-dbaas-cluster"
  password        = "SuperSecretPassword123!"
  replicas_enable = true
  replicas_number = 2
}

run "verify_replicas" {
  command = plan

  assert {
    condition     = length(mgc_dbaas_replicas.this) == 2
    error_message = "Should plan creation of 2 replicas"
  }

  assert {
    condition     = length(time_sleep.wait_for_master) == 1
    error_message = "Wait timer should be enabled when replicas are enabled"
  }

  assert {
    condition     = mgc_dbaas_replicas.this[0].name == "test-dbaas-cluster-rep-1"
    error_message = "Replica 1 name convention mismatch"
  }

  assert {
    condition     = mgc_dbaas_replicas.this[1].name == "test-dbaas-cluster-rep-2"
    error_message = "Replica 2 name convention mismatch"
  }
}
