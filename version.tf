terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = "0.18.10"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
  required_version = ">= 1.5.0"
}