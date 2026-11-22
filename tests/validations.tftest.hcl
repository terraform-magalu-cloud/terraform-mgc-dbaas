# Test input variable validations
provider "mgc" {
  api_key = "00000000-0000-4000-8000-000000000000"
  region  = "br-se1"
}

variables {
  name     = "test-validation"
  password = "SuperSecretPassword123!"
}

run "fail_on_invalid_engine" {
  command = plan

  variables {
    engine_name = "sqlserver"
  }

  expect_failures = [
    var.engine_name
  ]
}

run "fail_on_small_volume" {
  command = plan

  variables {
    volume_size = 5
  }

  expect_failures = [
    var.volume_size
  ]
}

run "fail_on_invalid_backup_time" {
  command = plan

  variables {
    backup_start_at = "25:00:00"
  }

  expect_failures = [
    var.backup_start_at
  ]
}

run "fail_on_invalid_api_key" {
  command = plan

  variables {
    api_key = "invalid-not-a-uuid"
  }

  expect_failures = [
    var.api_key
  ]
}


