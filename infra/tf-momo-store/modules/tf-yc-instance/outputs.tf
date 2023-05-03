output "interal_ip_k8s" {
  description = "internal IP k8s"
  value       = yandex_kubernetes_cluster.k8s.master[0].internal_v4_address
} 

output "exteral_ip_k8s" {
  description = "external IP k8s"
  value       = yandex_kubernetes_cluster.k8s.master[0].external_v4_address
} 

output "exteral_endpoin_k8s" {
  description = "external endpoint IP k8s"
  value       = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
} 

output "interal_endpoint_k8s" {
  description = "interal endpoint IP k8s"
  value       = yandex_kubernetes_cluster.k8s.master[0].internal_v4_endpoint
} 

output "ca_certificate_k8s" {
  description = "CA certificate k8s"
  value       = yandex_kubernetes_cluster.k8s.master[0].cluster_ca_certificate
} 