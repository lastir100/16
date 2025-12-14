terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.11"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = "~>1.12.0"

  backend "s3" {

    shared_credentials_files = ["~/.aws/credentials"]
    region                   = "ru-central1"
    profile                  = "default"

    bucket  = "lastir-netology-tfstate"
    key     = "test/terraform.tfstate"

    
    # Встроенный механизм блокировок (Terraform >= 1.6)
    # Не требует отдельной базы данных!
    use_lockfile = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  # token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}

provider "template" {}