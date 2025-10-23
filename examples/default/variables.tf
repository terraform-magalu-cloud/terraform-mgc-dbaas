variable "ssh_key_name" {
  description = "Name ssh key was created"
  type        = string
  default     = "key-example"
}

variable "password" {
  description = "Password to access database"
  type        = string
  sensitive   = true
  default = "P@ssw0rd"
}

variable "name" {
  description = "Name for the DBaaS cluster"
  type        = string
  default     = "my-db-cluster"
}

variable "user" {
  description = "Initial user for the database"
  type        = string
  default     = "admin"
  sensitive = true
}

variable "engine" {
  description = "Database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = "8.0"
}

variable "instance_type" {
  description = "Instance type for the database"
  type        = string
  default     = "BV4-8-10"
}

variable "volume_size" {
  description = "Database volume size in GB"
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "Database volume type"
  type        = string
  default     = "CLOUD_NVME_15K"
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 3
}

variable "backup_start_at" {
  description = "Time to start the backup (HH:MM:SS)"
  type        = string
  default     = "03:00:00"
}


variable "api_key" {
  description = "Magalu Cloud API key"
  type        = string
  sensitive   = true
} 

variable "region" {
  description = "Magalu Cloud region"
  type        = string
  default     = "br-ne1"
} 