variable "create" {
  description = "Defines whether resource will be created or not"
  default     = true
  type        = bool
}

variable "name" {
  description = "Defines the name of resource"
  type        = string
}

variable "instance_type" {
  description = "Define size instance database, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small"
  type        = string
  default     = "BV4-8-10"
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "Define which engine dbaas will be used. Possible values: 'mysql', 'postgresql'."
  validation {
    condition     = contains(["mysql", "postgresql"], var.engine)
    error_message = "The engine must be either 'mysql' or 'postgresql'."
  }
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "Engine version"
}

variable "user" {
  type        = string
  description = "Define name firts user to login dbaas"
  default     = "admin"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Define password firt user to login dbaas"
  sensitive   = true
  default     = "P@ssw0rd"
}

variable "volume_size" {
  type        = number
  description = "Define size volume in GB on dbaas"
  default     = 20
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

variable "replicas_enable" {
  type        = bool
  default     = false
  description = "Define if this dbaas use replica"
}

variable "replicas_number" {
  type        = number
  default     = 1
  description = "Define number of replica"
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

variable "custom_parameters" {
  description = "Custom parameters"
  type        = map(string)
  default     = {} # Padrão é um mapa vazio, o que significa que nenhum parâmetro será sobrescrito
}

variable "create_parameter_group" {
  description = "Enable or not create parameter group"
  type        = bool
  default     = true
}