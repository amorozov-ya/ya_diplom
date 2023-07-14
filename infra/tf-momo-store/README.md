# Разворачивание инфраструктуры k8s в YandexCloud при помощи модульной конфигурации Terraform
# Модули имеют дополнительное описание.
#
# Создается:
# 1. VPC - momo-vps
# 2. Private Subnet A
# 3. Внешний IP для Ingress
# 4. Bucket для хранения статитки максимальным размером 1 Гб.
# 5. Ползователи(права)
#   - k8s-manager (storage.admin, k8s.clusters.agent vpc.publicAdmin, alb.editor, certificate-manager.certificates.downloader, compute.viewer) 
#   - k8s-puller (ontainer-registry.images.puller)
# 6. Ключи для хранения секретов и бакета
# 7. K8s cluster, VPC Security Group (k8s-main-sg, k8s-public-services, k8s-nodes-ssh-access, k8s-master-whitelist, k8s-load-balancer )

# Variables:
# - token   (требуется для работы с облаком, читается из переменных среды TF_VAR_token)
# - cloud_id
# - folder_id
# - zone
# - subnet_a_ipv4_range
# - service_ipv4_range
# - cluster_ipv4_range



# Output:
# - interal_ip_k8s
# - exteral_ip_k8s
# - exteral_endpoin_k8s
# - interal_endpoint_k8s
# - ca_certificate_k8s
# - ip_ingress
