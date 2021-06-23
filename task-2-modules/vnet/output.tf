// Output the subnet IDs for the VMs

output "interface_ids" {
    value = {
        "public" = azurerm_network_interface.public.id
        "private" = azurerm_network_interface.private.id
    }
}