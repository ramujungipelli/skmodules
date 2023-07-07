output "nsg_name" {
  value= azurerm_network_security_group.hubnsg01.name
}

output "virtual_network_name"{
    value = azurerm_virtual_network.mainhubvnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet_name.name
}

# output "subnet_id" {
#   value = azurerm_subnet.subnet_name.id
# }