resource "yandex_vpc_network" "vpc" {
  name        = "momo1-vpc"
  description = "Momo-store network"
  folder_id   = var.folder_id
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "momo-subnet-a"
  description    = "Private sabnet zone-A"
  v4_cidr_blocks = [var.subnet_a_ipv4_range]
  folder_id      = var.folder_id
  zone           = var.zone
  network_id     = "${yandex_vpc_network.vpc.id}"
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name      = "momo-gateway"
  folder_id = var.folder_id
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "momo-gateway-table"
  network_id = "${yandex_vpc_network.vpc.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_address" "addr" {
  name = "momo-store"
  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_dns_zone" "zone1" {
  name        = "momopablic"
  description = "Momo-store public zone"
  labels = {
    label1 = var.dns_name
  }
  zone    = var.dns_name
  public  = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = var.dns_name
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "argo.${var.dns_name}"
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "grafana.${var.dns_name}"
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs4" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "promet.${var.dns_name}"
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs5" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "alert.${var.dns_name}"
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}
