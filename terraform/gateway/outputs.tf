output "public_ip" {
  value       = module.compute.public_ip_address
  description = "The Public IP of the VPN Gateway server"
}

output "private_ip" {
  value       = module.compute.private_ip_address
  description = "The Private IP of the VPN Gateway server"
}
