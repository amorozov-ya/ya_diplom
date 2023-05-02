variable "subnet_a_ipv4_range" {
  description = "Srvice k8s IP range"
  type        = string
  default     = "10.10.0.0/24"
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

variable "network_id" {
  description = "VPC network id"
  type        = string
  default     = ""
}