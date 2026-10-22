output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the Control Plane VM"
}

output "principal_id" {
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
  description = "The system-assigned managed identity principal ID"
}

output "public_ip_address" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the Control Plane VM"
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "The private IP address of the Control Plane VM"
}
