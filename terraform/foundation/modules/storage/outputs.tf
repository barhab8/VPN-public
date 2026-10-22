output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "primary_connection_string" {
  value     = azurerm_storage_account.sa.primary_connection_string
  sensitive = true
}

output "tfstate_container_name" {
  value = azurerm_storage_container.tfstate_gateways.name
}

output "clients_container_name" {
  value = azurerm_storage_container.clients.name
}
