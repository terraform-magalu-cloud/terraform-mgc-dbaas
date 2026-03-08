terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = ">= 0.45.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
  required_version = "~> 1.11.1"
}