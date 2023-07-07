# output "resource_group_name" {
#   value = azurerm_resource_group.resource_group.name
# }

# output "resource_group_location" {
#   value = azurerm_resource_group.resource_group.location
# }

output "nsg_name" {
  value= azurerm_network_security_group.hubnsg01.name
}

output "virtual_network_name"{
    value = azurerm_virtual_network.mainhubvnet.name
}

output "subnet_name" {
  value = azurerm_subnet.mainsubnet01.name
}

output "subnet_id" {
  value = azurerm_subnet.mainsubnet01.id
}