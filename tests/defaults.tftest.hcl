# Test default configuration with auto-generated credentials
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name = "test-dbaas-default"
}

run "verify_defaults" {
  command = plan

  assert {
    condition     = length(mgc_dbaas_instances.this) == 1
    error_message = "Primary DBaaS instance should be planned for creation"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].name == "test-dbaas-default"
    error_message = "Instance name mismatch"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_name == "mysql"
    error_message = "Default engine should be mysql"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].engine_version == "8.0"
    error_message = "Default engine version should be 8.0"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].instance_type == "DP2-8-40"
    error_message = "Default instance_type should be DP2-8-40"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].volume_size == 20
    error_message = "Default volume size should be 20 GB"
  }

  assert {
    condition     = mgc_dbaas_instances.this[0].backup_retention_days == 7
    error_message = "Default backup retention should be 7 days"
  }

  assert {
    condition     = length(random_password.master_password) == 1
    error_message = "Password should be automatically generated when omitted"
  }

  assert {
    condition     = length(mgc_dbaas_replicas.this) == 0
    error_message = "Replicas should be disabled by default"
  }



  assert {
    condition     = output.port == 3306
    error_message = "Default MySQL port should be 3306"
  }
}
