resource "yandex_vpc_security_group" "k8s-main-sg" {
  name        = "k8s-momostore-basic"
  description = "Basic work rules for Cluster and Node"
  network_id  = var.network_id

  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
    v4_cidr_blocks    = [ var.cluster_ipv4_range, var.service_ipv4_range ]
    from_port         = 0
    to_port           = 65535
  }  

  ingress {
    protocol          = "ICMP"
    description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks    = [ "10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12" ]
  }

  egress {
    protocol          = "ANY"
    description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s-public-services" {
  name        = "k8s-momostore-services"
  description = "Правила группы разрешают подключение к сервисам из интернета"
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }
}

resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
  name        = "k8s-momostore-nodes-ssh-access"
  description = "Правила группы разрешают подключение к узлам кластера по SSH. Примените правила только для групп узлов."
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к узлам по SSH с указанных IP-адресов."
    v4_cidr_blocks = ["92.62.58.0/24"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "k8s-master-whitelist" {
  name        = "k8s-momostore-master-whitelist"
  description = "Правила группы разрешают доступ к API Kubernetes из интернета."
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 6443 из указанной сети."
    v4_cidr_blocks = ["92.62.58.0/24", "95.161.177.0/24", "178.154.223.56/32"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 443 из указанной сети."
    v4_cidr_blocks = ["92.62.58.0/24", "95.161.177.0/24", "178.154.223.56/32"]
    port           = 443
  }
}


resource "yandex_vpc_security_group" "k8s-load-balancer" {
  name        = "k8s-momostore-load-balancer"
  description = "Правила группы разрешают доступ к LoadBalancer из интернета."
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение LoadBalancer порт 10501 из указанной сети."
    v4_cidr_blocks = [ var.subnet_a_ipv4_range ]
    port           = 10501
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение LoadBalancer порт 10502 из указанной сети."
    v4_cidr_blocks = [ var.subnet_a_ipv4_range ]
    port           = 10502
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение LoadBalancer через порт 80."
    v4_cidr_blocks = [ "0.0.0.0/0" ]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение LoadBalancer через порт 443."
    v4_cidr_blocks = [ "0.0.0.0/0"  ]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение LoadBalancer через порт 443."
    predefined_target = "loadbalancer_healthchecks"
    port           = 30080
  }

  egress {
    protocol          = "ANY"
    description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks    = [ var.subnet_a_ipv4_range ]
    from_port         = 0
    to_port           = 65535
  }
}
