output "resource_group_name" {
  value = module.resource_group.name
}

output "database_url" {
  value     = module.database.database_url
  sensitive = true
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_primary_connection_string" {
  value     = module.storage.primary_connection_string
  sensitive = true
}

output "tfstate_container_name" {
  value       = module.storage.tfstate_container_name
  description = "The Azure Blob container for storing gateway remote states"
}

output "control_plane_public_ip" {
  value       = module.control_plane.public_ip_address
  description = "The public IP of the Control Plane VM"
}

output "control_plane_private_ip" {
  value       = module.control_plane.private_ip_address
  description = "The private IP of the Control Plane VM"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.control_plane.vault_uri
  description = "Key Vault URI for KEY_VAULT_URL"
}

output "key_vault_name" {
  value       = azurerm_key_vault.control_plane.name
  description = "Key Vault name for az keyvault secret set commands"
}


