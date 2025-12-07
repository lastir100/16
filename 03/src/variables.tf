###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "cloud_id" {
  type        = string
  default     = "b1gfvoss4khmc3i6nfmj"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gfq8t7m21qpd3fdpmc"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOvLHUow4xL/do0YfCupDO3WTL5t5gy9aD5jMasc5fO lastir@netology"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible VM"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible VM"
}

variable "os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family name"
}

variable "org" {
  type        = string
  default     = "netology"
  description = "organization name"
}

variable "env" {
  type        = string
  default     = "develop"
  description = "environment"
}

variable "project" {
  type        = string
  default     = "platform"
  description = "project name"
}

variable "role_web" {
  type        = string
  default     = "web"
  description = "role web name"
}


locals {
    web_name = "${var.org}-${var.env}-${var.project}-${var.role_web}"
}

variable "vms_resources" {
  type = map(object({
      cores         = number
      memory        = number
      core_fraction = number
      disk_size     = number
      disk_type     = string
    }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      disk_size     = 5
      disk_type     = "network-hdd"
    },
    storage = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      disk_size     = 5
      disk_type     = "network-hdd"
    }
  }
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, disk_type=string,
      core_fraction=number }))
  default = [ {
      vm_name     = "main" 
      cpu         = 4 
      ram         = 8 
      disk_volume = 10
      disk_type   = "network-hdd"
      core_fraction = 5
    },
    {
      vm_name     = "replica" 
      cpu         = 2 
      ram         = 4 
      disk_volume = 5
      disk_type   = "network-hdd"
      core_fraction = 5
    }
  ]
}

locals {
  db_vms_map = {
    for vm in var.each_vm : vm.vm_name => vm
  }
}