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
    condition     = length(regexall("cloud-dbaas-(bs1|gp1|hm1).(small|medium|large)", var.flavor)) > 0
    error_message = "Value not found, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small"
  }
}

variable "engine" {
  type        = string
  default     = "mysql-8.0"
  description = "Definie which egine dbaas will be use"
  validation {
    condition     = length(regexall("mysql-(5.6|5.7|8.0)", var.engine)) > 0
    error_message = "Value not found, possible values: mysq-5.6, mysql-5.7 and mysql-8.0"
  }
}

variable "user" {
  type        = string
  description = "Define name firts user to login dbaas"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "Define password firt user to login dbaas"
  sensitive   = true
}

variable "volume_size" {
  type        = number
  description = "Define size volume in GB on dbaas"
  default     = 20
}

variable "volume_type" {
  default     = "CLOUD_NVME_15K"
  description = "Define type volume in GB on dbaas"
  type        = string
}

variable "backup_retention_days" {
  default     = 7
  type        = number
  description = "Define days to backup frequency of the dbaas"
}

variable "backup_start_at" {
  type        = string
  default     = "02:00:00"
  description = "Define hour start backup of the dbaas"
}

variable "backup_enable" {
  type        = bool
  default     = true
  description = "Define if backup is enable of the dbaas"
}

variable "exchange" {
  default     = "dbaas-internal"
  type        = string
  description = "Define exchange type"
}

variable "replicas_enable" {
  type        = bool
  default     = false
  description = "Define if this dbaas use replica"
}

variable "replicas_num_hosts" {
  type        = number
  default     = 1
  description = "Define number hosts to be replica thiss dbaas"
  validation {
    condition     = var.replicas_num_hosts > 0
    error_message = "This value can1t less than 1"
  }
}

variable "bastion_enable" {
  type        = bool
  default     = false
  description = "Defini if bastion server will be create to acces database by CLI"

}
variable "bastion_ssh_key_name" {
  type        = string
  default     = ""
  description = "Name of ssh key name to bastion server to access DB"
}
