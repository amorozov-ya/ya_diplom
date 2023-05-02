output "access_key" {
  description = "Access key for create Bucket"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
} 

output "secret_key" {
  description = "Secret key for create Bucket"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
} 

output "kms-key" {
  description = "Secret key for pass, ssh-key, token"
  value       = yandex_kms_symmetric_key.kms-key
} 

output "sa" {
  description = "Service accaunt"
  value       = yandex_iam_service_account.sa
} 

output "na" {
  description = "Node conteiner registry, puller"
  value       = yandex_iam_service_account.na
} 

output "finish" {
  description = "finish add RIGHTS "
  value = {}
  depends_on = [yandex_resourcemanager_folder_iam_member.vpc-public-admin, yandex_resourcemanager_folder_iam_member.k8s-clusters-agent, yandex_resourcemanager_folder_iam_member.images-puller ]
}

