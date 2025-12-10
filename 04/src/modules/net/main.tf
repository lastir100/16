terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4" 
}

resource "yandex_vpc_network" "vpc_net" {
  name = var.env_name
}
resource "yandex_vpc_subnet" "vpc_subnet" {
  name           = var.env_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_net.id
  v4_cidr_blocks = var.cidr
}