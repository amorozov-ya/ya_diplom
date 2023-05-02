output "interal_ip_k8s" {
  description = "internal IP k8s"
  value       = module.cloud_k8s_instance.interal_ip_k8s
} 

output "exteral_ip_k8s" {
  description = "external IP k8s"
  value       = module.cloud_k8s_instance.exteral_ip_k8s
} 

output "exteral_endpoin_k8s" {
  description = "external endpoint IP k8s"
  value       = module.cloud_k8s_instance.exteral_endpoin_k8s
} 

output "interal_endpoint_k8s" {
  description = "interal endpoint IP k8s"
  value       = module.cloud_k8s_instance.interal_endpoint_k8s
} 

output "ca_certificate_k8s" {
  description = "CA certificate k8s"
  value       = module.cloud_k8s_instance.ca_certificate_k8s
} 

output "ip_ingress" {
  description = "momo-store IP for ingress"
  value       = module.cloud_network.ip_ingress
} 