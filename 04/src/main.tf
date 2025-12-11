# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

module "vpc_prod" {
  source       = "./modules/net"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file(var.ssh_public_key)
  }
}

module "vm-marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc_prod.network_id
  subnet_zones   = module.vpc_prod.subnet_zones
  subnet_ids     = module.vpc_prod.subnet_ids
  instance_name  = "vm-marketing"
  instance_count = 3
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  platform       = "standard-v3"
  instance_core_fraction = 20

  labels = { 
    owner= "a.minin",
    project = "marketing"
    }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}

module "vm-analytics" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc_prod.network_id
  subnet_zones   = module.vpc_prod.subnet_zones
  subnet_ids     = module.vpc_prod.subnet_ids
  instance_name  = "vm-analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

    labels = { 
    owner= "a.minin",
    project = "analytics"
    }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}