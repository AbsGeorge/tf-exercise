// Output the VM IPs

output "public_public_ip" {
  value = azurerm_linux_virtual_machine.public.public_ip_address
}

output "private_public_ip" {
  value = azurerm_linux_virtual_machine.private.public_ip_address
}

// Private IP Output
output "public_private_ip" {
  value = azurerm_linux_virtual_machine.public.private_ip_address
}
output "private_private_ip" {
  value = azurerm_linux_virtual_machine.private.private_ip_address
}

// VM Name Output
output "public_vm_name" {
  value = azurerm_linux_virtual_machine.public.name
}
output "private_vm_name" {
  value = azurerm_linux_virtual_machine.private.name
}

// Admin User Output
output "public_admin_user" {
  value = azurerm_linux_virtual_machine.public.admin_username
}

output "private_admin_user" {
  value = azurerm_linux_virtual_machine.private.admin_username
}
