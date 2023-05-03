resource "time_sleep" "wait" {
  create_duration = "60s"
}

resource "yandex_storage_bucket" "backet" {
  access_key = var.sa-access_key
  secret_key = var.sa-secret_key
  bucket = var.name_backet_pictures
  default_storage_class = "STANDARD"
  acl = "public-read-write"
  max_size   = 1073741824
  versioning {
    enabled = false
  }
  depends_on = [time_sleep.wait]
}

resource "yandex_kubernetes_cluster" "k8s" {
  name = "k8s-momo"
  description = "k8s cluster"
  network_id = var.network_id
  cluster_ipv4_range = var.cluster_ipv4_range
  service_ipv4_range = var.service_ipv4_range
  labels = {
    app       = "momo-store"
    service = "k8s"
  }
  master {
    version = var.k8s_version
    public_ip = true
    zonal {
      zone      = var.subnet_zone
      subnet_id = var.subnet_ids
    }
    security_group_ids = var.security_group_ids_cluster
  }
  service_account_id      = var.sa_id
  node_service_account_id = var.na_id

  release_channel = "STABLE"
  kms_provider {
    key_id = var.kms_symmetric_key
  }
  depends_on = [var.storage_account_depends_on, yandex_storage_bucket.backet]
}

resource "yandex_kubernetes_node_group" "worker-node" {
  cluster_id = yandex_kubernetes_cluster.k8s.id
  name       = "worker-node"
  version    = var.k8s_version
  instance_template {
    name = "prod-{instance.index}-{instance_group.id}-{instance.zone_id}"
    platform_id = "standard-v1"
    labels = {
      nodes ="worker"
    }
    container_runtime {
        type = "docker"
    }
    resources {
        cores = 2
        memory = 4
    }    
    boot_disk {
        size = 40
        type = "network-hdd"
    }
    network_interface {
      nat                = false
      subnet_ids         = [var.subnet_id]
      security_group_ids = var.security_group_ids_node
    }
    scheduling_policy {
        preemptible = false
    }
  }
  scale_policy {
      auto_scale {
        min     = 2
        max     = 4
        initial = 2
      }
  }

}
