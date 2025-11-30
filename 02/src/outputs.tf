output "vms_info" {
   value = [
    { vm1 = [ yandex_compute_instance.platform.name, yandex_compute_instance.platform.network_interface[0].nat_ip_address, yandex_compute_instance.platform.fqdn] },
    { vm2 = [ yandex_compute_instance.platform-db.name, yandex_compute_instance.platform-db.network_interface[0].nat_ip_address, yandex_compute_instance.platform-db.fqdn] }
    
  ]
}

output "vms_info_improved" {
  description = "Основные параметры виртуальных машин в удобном формате."
  value = {
    vm1 = {
      name = yandex_compute_instance.platform.name
      nat_ip = yandex_compute_instance.platform.network_interface[0].nat_ip_address
      fqdn   = yandex_compute_instance.platform.fqdn
    },
    vm2 = {
      name = yandex_compute_instance.platform-db.name
      nat_ip = yandex_compute_instance.platform-db.network_interface[0].nat_ip_address
      fqdn   = yandex_compute_instance.platform-db.fqdn
    }
  }
}