# 1. Создание груп безопасности для:
# - Кластера k8s (k8s-main-sg, k8s-master-whitelist)
# - Для ноды кластреа k8s (k8s-main-sg, k8s-nodes-ssh-access, k8s-public-services)
# - Для балансировщика (k8s-load-balancer)

# Output:
# - k8s-main-sg
# - k8s-master-whitelist
# - k8s-nodes-ssh-access
# - k8s-public-services
# - k8s-load-balancer

# Variables: 
# - network_id
# - subnet_a_ipv4_range
# - cluster_ipv4_range
# - service_ipv4_range