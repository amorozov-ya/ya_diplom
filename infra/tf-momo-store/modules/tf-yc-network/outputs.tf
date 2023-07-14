output "network" {
  description = "VPC network ID"
  value       = yandex_vpc_network.vpc
} 

output "subnet" {
  description = "VPC network ID"
  value       = yandex_vpc_subnet.subnet-a
} 

output "ip_ingress" {
  description = "momo-store IP for ingress"
  value       = yandex_vpc_address.addr.external_ipv4_address[0].address
} 
