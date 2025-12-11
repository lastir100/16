
output "network_id" {
  value = yandex_vpc_network.vpc_net.id
}

output "subnet_ids" {
  value = yandex_vpc_subnet.vpc_subnet[*].id
}

output "subnet_zones" {
  value = yandex_vpc_subnet.vpc_subnet[*].zone
}

