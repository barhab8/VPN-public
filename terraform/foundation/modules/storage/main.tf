resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "${replace(var.prefix, "-", "")}storage${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags

  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_queue" "tasks" {
  name                 = "vpn-tasks"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_queue" "poison" {
  name                 = "vpn-tasks-poison"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_container" "tfstate_gateways" {
  name                  = "tfstate-gateways"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "clients" {
  name                  = "clients"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
