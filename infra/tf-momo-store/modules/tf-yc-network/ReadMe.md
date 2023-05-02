# 1. Создание виртуальной сети - momo1-vpc
# 2. Создание подсетей momo-subnet-a
# 3. Создание внешнего IP для Ingress
# 4. Создание статического маршрута для доступа во вне из подсетей 
#

# Output:
# - network (VPC)
# - subnet
# - ip_ingress
#
# Variable:
# - zone
# - folder_id
# - subnet_a_ipv4_range
# - dns_name