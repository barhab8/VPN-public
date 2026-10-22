output "db_host" {
  value = azurerm_postgresql_flexible_server.db.fqdn
}

output "db_name" {
  value = azurerm_postgresql_flexible_server_database.defaultdb.name
}

output "db_user" {
  value = azurerm_postgresql_flexible_server.db.administrator_login
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "database_url" {
  value     = "postgresql://${azurerm_postgresql_flexible_server.db.administrator_login}:${random_password.db_password.result}@${azurerm_postgresql_flexible_server.db.fqdn}/${azurerm_postgresql_flexible_server_database.defaultdb.name}"
  sensitive = true
}
