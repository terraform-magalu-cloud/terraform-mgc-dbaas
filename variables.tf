# tflint-ignore: terraform_unused_declarations
variable "api_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Magalu Cloud API Key for provider authentication (UUID v4 format). Can also be provided via the MGC_API_KEY environment variable"
  validation {
    condition     = var.api_key == null || can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$", var.api_key))
    error_message = "api_key must be a valid UUID v4 format (e.g. 00000000-0000-4000-8000-000000000000)."
  }
}

variable "create" {
  description = "Defines whether DBaaS resources will be created or not"
  default     = true
  type        = bool
}

variable "name" {
  description = "Name of the DBaaS instance or cluster"
  type        = string
}

variable "deployment_type" {
  type        = string
  default     = "standalone"
  description = "Deployment topology: 'standalone' (single instance), 'replicas' (primary + read replicas), or 'cluster' (High Availability cluster)"
  validation {
    condition     = contains(["standalone", "replicas", "cluster"], var.deployment_type)
    error_message = "var.deployment_type must be one of: 'standalone', 'replicas', 'cluster'."
  }
}

variable "user" {
  type        = string
  description = "Administrative user for the database instance"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "Administrative password for the database. If omitted (null), a strong 24-character random password is automatically generated"
  default     = null
  sensitive   = true
}

variable "database_name" {
  type        = string
  default     = null
  description = "Name of the initial logical database to include in connection string outputs"
}

variable "engine_name" {
  type        = string
  default     = "mysql"
  description = "Database engine name (e.g., 'mysql' or 'postgresql')"
  validation {
    condition     = contains(["mysql", "postgresql"], var.engine_name)
    error_message = "Supported engine names are: 'mysql', 'postgresql'."
  }
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "Database engine version (e.g., '8.0' for mysql or '15', '16' for postgresql)"
}

variable "port" {
  type        = number
  default     = null
  description = "Custom port for the database. Defaults to 3306 (mysql) or 5432 (postgresql)"
}

variable "instance_type" {
  description = "Compute instance type label (e.g. DP2-8-40, DP2-16-40)"
  type        = string
  default     = "DP2-8-40"
}

variable "volume_size" {
  type        = number
  description = "Storage volume size in GB for the database"
  default     = 20
  validation {
    condition     = var.volume_size >= 10
    error_message = "Volume size must be at least 10 GB."
  }
}

variable "volume_type" {
  default     = "CLOUD_NVME15K"
  description = "Storage performance tier volume type (e.g., CLOUD_NVME15K, CLOUD_NVME20K)"
  type        = string
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "Target availability zone for deployment (e.g., 'br-se1-a', 'br-ne1-a')"
}

variable "backup_enable" {
  type        = bool
  default     = true
  description = "Define if automated backups are enabled"
}

variable "backup_retention_days" {
  default     = 7
  type        = number
  description = "Number of days to retain automated backups"
  validation {
    condition     = var.backup_retention_days >= 1
    error_message = "Backup retention days must be at least 1 day."
  }
}

variable "backup_start_at" {
  type        = string
  default     = "02:00:00"
  description = "Daily backup start time in UTC format (HH:MM:SS)"
  validation {
    condition     = can(regex("^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$", var.backup_start_at))
    error_message = "backup_start_at must follow the HH:MM:SS format."
  }
}

variable "replicas_enable" {
  type        = bool
  default     = false
  description = "Legacy / flag: Define whether to create read replicas (superseded by deployment_type = 'replicas')"
}

variable "replicas_number" {
  type        = number
  default     = 1
  description = "Number of read replicas to create when deployment_type is 'replicas' or replicas_enable is true"
  validation {
    condition     = var.replicas_number >= 0
    error_message = "replicas_number must be greater than or equal to 0."
  }
}

variable "replica_wait_duration" {
  type        = string
  default     = "1m"
  description = "Duration to wait before provisioning replicas after the primary instance is created"
}



# Legacy support variables
variable "engine" {
  type        = string
  default     = null
  description = "Legacy: Database engine and version combined (e.g. 'mysql-8.0'). Deprecated in favor of engine_name and engine_version"
}

variable "flavor" {
  type        = string
  default     = null
  description = "Legacy: Compute flavor. Deprecated in favor of instance_type"
}

# tflint-ignore: terraform_unused_declarations
variable "exchange" {
  type        = string
  default     = null
  description = "Legacy: Exchange network type"
}
