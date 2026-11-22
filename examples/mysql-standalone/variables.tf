variable "api_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Magalu Cloud API Key"
}

variable "region" {
  type        = string
  default     = "br-se1"
  description = "Magalu Cloud Region"
}
