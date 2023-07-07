resource "azurerm_network_security_group" "hubnsg01" {
  name                = var.nsg_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "mainhubvnet" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["172.16.0.0/16"]
  dns_servers         = ["172.16.0.4", "172.16.0.5"]

  

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "subnet_name" {   
  name                 = var.subnet_name  
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["172.16.10.0/24"]

}
output "subnet_id" {
    value = azurerm_subnet.subnet_name.id
}

