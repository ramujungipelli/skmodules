# resource "azurerm_resource_group" "resource_group" {
#   name     = var.resource_group_name
#   location = var.resource_group_location
# }
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

resource "azurerm_subnet" "mainsubnet01" {   #hubsubnet01 is refrence name in terraform
  name                 = var.subnet_name  #this will create subnet in cloud
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["172.16.10.0/24"]

}


