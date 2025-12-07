variable "add_disk_name" {
  type        = string
  default     = "disk"
  description = "additional disk name"
}

variable "add_disks_amount" {
  type        = number
  default     = 3
  description = "additional disks amount"
}

variable "add_disks_type" {
  type        = string
  default     = "network-hdd"
  description = "additional disks type"
}

variable "add_disks_size" {
  type        = number
  default     = 1
  description = "additional disks size"
}

resource "yandex_compute_disk" "empty-disk" {

  count = var.add_disks_amount

  name       = "${var.add_disk_name}-${count.index}"
  type       = var.add_disks_type
  zone       = var.default_zone
  size       = var.add_disks_size
}

variable "vm_storage_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_storage_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible VM"
}

variable "vm_storage_name" {
  type        = string
  default     = "storage"
}

resource "yandex_compute_instance" "storage" {

  name        = var.vm_storage_name #Имя ВМ в облачной консоли
  hostname    = var.vm_storage_name #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.vm_storage_platform

  resources {
    cores         = var.vms_resources.storage.cores
    memory        = var.vms_resources.storage.memory
    core_fraction = var.vms_resources.storage.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.storage.disk_type
      size     = var.vms_resources.storage.disk_size
    }
  }

  dynamic "secondary_disk" {
    # 1. Задаем источник данных для итерации (список созданных дисков)
    for_each = tolist(yandex_compute_disk.empty-disk) 
    
    # 2. Имя итератора 
    iterator = disk_item 

    # 3. Определяем содержимое блока secondary_disk
    content {
      # Для подключения существующего диска достаточно указать его ID.
      # ID берется из текущего элемента итерации (disk_item.value.id)
      disk_id = disk_item.value.id
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