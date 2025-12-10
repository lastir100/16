output "subnet_id" {
  value = yandex_vpc_subnet.vpc_subnet.id
}

output "network_id" {
  value = yandex_vpc_network.vpc_net.id
}

output "subnet_zone" {
  value = yandex_vpc_subnet.vpc_subnet.zone
}

