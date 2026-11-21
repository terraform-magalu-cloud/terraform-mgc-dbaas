terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = ">= 0.56.0, < 1.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.11.0, < 1.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0, < 4.0.0"
    }
  }
  required_version = ">= 1.6.0"
}
