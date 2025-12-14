# Чтобы Terraform не падал, используем can():
variable "ip_address" {
  type        = string
  description = "ip-адрес"

  validation {
    condition = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "Значение должно быть корректным IPv4-адресом."
  }
  default = "1920.1680.0.1"
  # default = "192.168.0.1"
}

variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"

  validation {
    condition = alltrue([
      for ip in var.ip_list :
      can(cidrhost("${ip}/32", 0))
    ])
    error_message = "Все элементы списка должны быть корректными IPv4-адресами."
  }
  default = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  # default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
}
