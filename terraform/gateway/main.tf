terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  use_msi = true
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.server_name}-rg"
  location = var.region
  tags     = var.tags
}

module "network" {
  source                  = "./modules/network"
  prefix                  = var.server_name
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  control_plane_ip        = var.control_plane_ip
  tags                    = var.tags
}

module "compute" {
  source                    = "./modules/compute"
  prefix                    = var.server_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  subnet_id                 = module.network.subnet_id
  vm_size                   = var.vm_size
  zone                      = var.zone
  admin_username            = var.admin_username
  admin_ssh_public_key_path = var.admin_ssh_public_key_path
  os_type                   = var.os_type
  tags                      = var.tags
}
