resource "yandex_compute_instance" "db" {

  for_each = local.db_vms_map

  name        = each.key #Имя ВМ в облачной консоли
  hostname    = each.key #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.vm_db_platform

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = each.value.disk_type
      size     = each.value.disk_volume
    }
  }

  metadata = {
    ssh-keys = file("~/.ssh/id_ed25519.pub")
  }

  scheduling_policy { preemptible = var.vm_web_preemptible }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  allow_stopping_for_update = true
}