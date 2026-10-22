output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the Virtual Machine"
}

output "public_ip_address" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The Public IP Address of the VPN Gateway"
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "The Private IP Address of the VPN Gateway"
}
