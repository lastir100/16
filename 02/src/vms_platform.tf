variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_b" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}




# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "VM name"
# }

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "number of cores vCPU"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "memory in Gb for VM"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "core fraction of vCPU"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible VM"
}