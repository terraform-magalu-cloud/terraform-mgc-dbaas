# Test High Availability Database Cluster
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name            = "test-dbaas-ha-cluster"
  deployment_type = "cluster"
  engine_name     = "mysql"
  engine_version  = "8.0"
}

run "verify_cluster_topology" {
  command = plan

  assert {
    condition     = length(mgc_dbaas_clusters.this) == 1
    error_message = "Should plan creation of 1 HA Cluster resource"
  }

  assert {
    condition     = length(mgc_dbaas_instances.this) == 0
    error_message = "Should NOT plan standalone instances when deployment_type = 'cluster'"
  }

  assert {
    condition     = length(mgc_dbaas_replicas.this) == 0
    error_message = "Should NOT plan standalone replicas when deployment_type = 'cluster'"
  }

  assert {
    condition     = mgc_dbaas_clusters.this[0].name == "test-dbaas-ha-cluster"
    error_message = "Cluster name mismatch"
  }

  assert {
    condition     = length(random_password.master_password) == 1
    error_message = "Should auto-generate secure password when none provided"
  }
}
