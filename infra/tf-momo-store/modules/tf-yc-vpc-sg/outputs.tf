output "k8s-main-sg" {
  description = "VPC network ID"
  value       = yandex_vpc_security_group.k8s-main-sg
} 

output "k8s-public-services" {
  description = "VPC network ID"
  value       = yandex_vpc_security_group.k8s-public-services
} 

output "k8s-nodes-ssh-access" {
  description = "VPC network ID"
  value       = yandex_vpc_security_group.k8s-nodes-ssh-access
} 

output "k8s-master-whitelist" {
  description = "VPC network ID"
  value       = yandex_vpc_security_group.k8s-master-whitelist
} 

output "k8s-load-balancer" {
  description = "VPC network ID"
  value       = yandex_vpc_security_group.k8s-load-balancer
} 
