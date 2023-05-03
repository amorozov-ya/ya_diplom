module "cloud_network" {
    source = "./modules/tf-yc-network"
    zone = var.zone
}   

module "cloud_accounts" {
    source = "./modules/tf-yc-accounts"
    folder_id = var.folder_id
}   


module "cloud_sec" {
    source = "./modules/tf-yc-vpc-sg"
    network_id  = module.cloud_network.network.id
    subnet_a_ipv4_range = var.subnet_a_ipv4_range
    cluster_ipv4_range = var.cluster_ipv4_range
    service_ipv4_range = var.service_ipv4_range 
}   

module "cloud_k8s_instance" {
    source = "./modules/tf-yc-instance"
    sa-access_key  = module.cloud_accounts.access_key
    sa-secret_key = module.cloud_accounts.secret_key
    kms_symmetric_key = module.cloud_accounts.kms-key.id
    network_id = module.cloud_network.network.id
    subnet_zone = module.cloud_network.subnet.zone
    subnet_id = module.cloud_network.subnet.id
    cluster_ipv4_range = var.cluster_ipv4_range
    service_ipv4_range = var.service_ipv4_range 
    sa_id = module.cloud_accounts.sa.id
    na_id = module.cloud_accounts.na.id
    subnet_ids = module.cloud_network.subnet.id
    security_group_ids_cluster = [ module.cloud_sec.k8s-main-sg.id, module.cloud_sec.k8s-master-whitelist.id ]
    security_group_ids_node = [ module.cloud_sec.k8s-main-sg.id, module.cloud_sec.k8s-nodes-ssh-access.id, module.cloud_sec.k8s-public-services.id ]
    storage_account_depends_on =  module.cloud_accounts.finish
} 