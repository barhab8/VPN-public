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
  backend "azurerm" {
    resource_group_name  = "cloudvpn-rg"
    storage_account_name = "<YOUR_STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "foundation.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "random_string" "key_vault_suffix" {
  length  = 6
  special = false
  upper   = false
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.prefix}-rg"
  location            = var.location
  tags                = var.tags
}

module "network" {
  source                  = "./modules/network"
  prefix                  = var.prefix
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  tags                    = var.tags
}

module "storage" {
  source              = "./modules/storage"
  prefix              = var.prefix
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = var.tags
}

module "database" {
  source              = "./modules/database"
  prefix              = var.prefix
  resource_group_name = module.resource_group.name
  location            = "northeurope"
  admin_username      = var.db_admin_username
  tags                = var.tags
}

module "control_plane" {
  source                    = "./modules/control_plane"
  prefix                    = var.prefix
  resource_group_name       = module.resource_group.name
  location                  = module.resource_group.location
  subnet_id                 = module.network.subnet_id
  vm_size                   = var.control_plane_vm_size
  admin_username            = var.admin_username
  admin_ssh_public_key_path = var.admin_ssh_public_key_path
  tags                      = var.tags
}

resource "azurerm_key_vault" "control_plane" {
  name                       = "${var.prefix}-kv-${random_string.key_vault_suffix.result}"
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
  tags                       = var.tags
}

resource "azurerm_role_assignment" "control_plane_key_vault_secrets_user" {
  scope                = azurerm_key_vault.control_plane.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.control_plane.principal_id
}

resource "azurerm_role_assignment" "deployer_key_vault_secrets_officer" {
  scope                = azurerm_key_vault.control_plane.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}


