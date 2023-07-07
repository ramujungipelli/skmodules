terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.64.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "resource_group" {
  source                  = "./modules/resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "vnets" {
  source                  = "./modules/vnets"
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
  nsg_name                = var.nsg_name
  virtual_network_name    = var.virtual_network_name
  subnet_name             = var.subnet_name


}

module "vms" {
  source                  = "./modules/vms"
  count                   = length(var.vm_name)
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
  nsg_name                = module.vnets.nsg_name
  virtual_network_name    = module.vnets.virtual_network_name
  subnet_name             = module.vnets.subnet_name
  subnet_id               = module.vnets.subnet_id
  network_interface       = var.network_interface[count.index]
  vm_name                 = var.vm_name[count.index]
  vm_size                 = var.vm_size
  username                = var.username
  storage_account_type    = var.storage_account_type
  public_ip_name          = var.public_ip_name
}
