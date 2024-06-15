variable "create" {
  description = "Defines whether resource will be created or not"
  default     = true
  type        = bool
}

variable "name" {
  description = "Defines the name of resource"
  default     = "test-db-terraform"
  type        = string
}

variable "flavor" {
  description = "Define size instance database, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small"
  type        = string
  default     = "cloud-dbaas-bs1.medium"
  validation {
    condition = length(regexall("cloud-dbaas-(bs1|gp1|hm1).(small|medium|large)", var.flavor)) > 0
    error_message = "Value not found, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small"
  }
}

variable "user" {
  type        = string
  description = "value"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "value"
  default     = "abc0123asdmc"
}

variable "volume_size" {
  type        = number
  description = "value"
  default     = 10
}

variable "volume_type" {
  default     = "CLOUD_NVME_15K"
  description = "value"
  type        = string
}

variable "backup_retention_days" {
  default     = 7
  type        = number
  description = "value"
}

variable "backup_start_at" {
  type        = string
  default     = "02:00:00"
  description = "value"
}

variable "backup_enable" {
  type        = bool
  default     = true
  description = "value"
}

variable "exchange" {
  default     = "dbaas-internal"
  type        = string
  description = "value"
}

variable "replicas_enable" {
  type        = bool
  default     = true
  description = "value"
}

variable "replicas_num_hosts" {
  type        = number
  default     = 2
  description = "value"
}


variable "engine" {
  type = string
  default = "mysql-8.0"
  description = "value"
  validation {
    condition = length(regexall("mysql-(5.6|5.7|8.0)",var.engine)) > 0 
    error_message = "Value not found, possible values: mysq-5.6, mysql-5.7 and mysql-8.0"
  }
}