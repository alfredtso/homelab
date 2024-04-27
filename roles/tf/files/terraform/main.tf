terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
      version = "2.0.0"
    }
  }
}

provider "lxd" {
}

locals {
  gateway4 = "10.188.251.1"
}

resource "lxd_instance" "control" {
  name  = "control"
  image = "ubuntu:22.04"

  config = {
    "cloud-init.user-data" = file("./my-user-data"),
    #"cloud-init.network-config" = file("./my-network-config")
    "cloud-init.network-config" = templatefile("./netplan.tfpl", 
    {
      ipv4_addr = "10.188.251.100/24",
      gateway4 = local.gateway4
    })
  }
}

resource "lxd_instance" "worker1" {
  name  = "worker1"
  image = "ubuntu:22.04"

  config = {
    "cloud-init.user-data" = file("./my-user-data"),
    #"cloud-init.network-config" = file("./my-network-config")
    "cloud-init.network-config" = templatefile("./netplan.tfpl", 
    {
      ipv4_addr = "10.188.251.101/24"
      gateway4 = local.gateway4
    })
  }
}

resource "lxd_instance" "worker2" {
  name  = "worker2"
  image = "ubuntu:22.04"

  config = {
    "cloud-init.user-data" = file("./my-user-data"),
    #"cloud-init.network-config" = file("./my-network-config")
    "cloud-init.network-config" = templatefile("./netplan.tfpl", 
    {
      ipv4_addr = "10.188.251.102/24"
      gateway4 = local.gateway4
    })
  }
}
