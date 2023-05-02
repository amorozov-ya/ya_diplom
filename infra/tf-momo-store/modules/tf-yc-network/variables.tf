variable "zone" {
  description = "For block Provider"
  type        = string
  default     = "ru-central1-a"
}

variable "dns_name" {
  description = "DNS addres"
  type        = string
  default     = "momostoreby.site."
}

variable "folder_id" {
  description = "For block Provider"
  type        = string
  default     = "b1g7qvsquqir82m0qm6k"
}

variable "subnet_a_ipv4_range" {
  description = "Srvice k8s IP range"
  type        = string
  default     = "10.10.0.0/24"
  sensitive   = true
}
