variable "k8s_version" {
  description = "Version install k8s"
  type        = string
  default     = "1.23"
  sensitive   = true
}

variable "sa_id" {
  description = "Service accaunt"
  type        = string
  default     = ""
}

variable "na_id" {
  description = "Node conteiner registry, puller"
  type        = string
  default     = ""
}

variable "sa-access_key" {
  description = "Access key for create Backet"
  type        = any
}

variable "sa-secret_key" {
  description = "Secret key for create Backet"
  type        = any
}

variable "kms_symmetric_key" {
  description = "Secret key for pass, ssh-key, token"
  type        = any
}

variable "subnet_zone" {
  description = "For block Provider"
  type        = string
  default     = "ru-central1-a"
}

variable "network_id" {
  description = "VPC network id"
  type        = string
  default     = ""
}


variable "subnet_id" {
  description = "Subnet ID for cluster k8s"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Subnets ID for node k8s"
  type        = string
  default     = ""
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

variable "name_backet_pictures" {
  description = "Name backet for picture backend"
  type        = string
  default     = "momo-store-site-test1"
  sensitive   = true
}

variable "security_group_ids_cluster" {
  description = "Security group for cluster"
  type        = list (string)
  default     = []
  sensitive   = true
}

variable "security_group_ids_node" {
  description = "Security group for node"
  type        = list (string)
  default     = []
  sensitive   = true
}

variable "storage_account_depends_on" {
  type    = any
  default = []
}