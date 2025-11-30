###cloud vars


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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOvLHUow4xL/do0YfCupDO3WTL5t5gy9aD5jMasc5fO lastir@netology"
  description = "ssh-keygen -t ed25519"
}

variable "os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family name"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "number of cores vCPU"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "memory in Gb for VM"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "core fraction of vCPU"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible VM"
}