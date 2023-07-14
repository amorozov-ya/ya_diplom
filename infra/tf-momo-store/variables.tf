variable "token" {
  description = "For block Provider"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloud_id" {
  description = "For block Provider"
  type        = string
  default     = "b1g3a33d8r81vfr1i9ov"
}

variable "folder_id" {
  description = "For block Provider"
  type        = string
  default     = "b1g7qvsquqir82m0qm6k"
}

variable "zone" {
  description = "For block Provider"
  type        = string
  default     = "ru-central1-a"
} 

variable "subnet_a_ipv4_range" {
  description = "Srvice k8s IP range"
  type        = string
  default     = "10.10.0.0/24"
  sensitive   = true
}

variable "subnet_b_ipv4_range" {
  description = "Srvice k8s IP range"
  type        = string
  default     = "10.11.0.0/24"
  sensitive   = true
}

variable "service_ipv4_range" {
  description = "Srvice k8s IP range"
  type        = string
  default     = "10.50.0.0/16"
  sensitive   = true
}

variable "cluster_ipv4_range" {
  description = "Cluster k8s IP range"
  type        = string
  default     = "10.60.0.0/16"
  sensitive   = true
}
