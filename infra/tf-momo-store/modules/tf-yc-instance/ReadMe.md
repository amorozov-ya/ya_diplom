# Создается:
# 1. Bucket для хранения статитки максимальным размером 1 Гб.
# 2. K8s cluster
# 3. K8s node group (2 cores, 2  memory, autoscale min-max:2-4, 30 Gb HDD)




# Variables:
# - k8s_version
# - sa_id
# - na_id
# - sa-access_key
# - sa-secret_key
# - kms_symmetric_key
# - subnet_zone
# - network_id
# - subnet_id
# - subnet_ids
# - service_ipv4_range
# - cluster_ipv4_range
# - name_backet_pictures
# - security_group_ids_cluster
# - security_group_ids_node
# - storage_account_depends_on



# Output:
# - interal_ip_k8s
# - exteral_ip_k8s
# - exteral_endpoin_k8s
# - interal_endpoint_k8s
# - ca_certificate_k8s
# - finish
