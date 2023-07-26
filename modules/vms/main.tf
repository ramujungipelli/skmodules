locals {
  first_public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5VCYgMWQYyIxe7hJJelZKgWohVghv0988dlPvxwqbluWx5DWqBj3lGqmKKQs6o2srs/YQKpFLmRlqZV+R8uRnZauz51zDkSc2cHsiGIrDj/jTHMQmX65vv0DNhRPwmmUfeoCbsZ4RWgKg+QR2nFlnWHdj/yOGwCYOdz8gYczSaMbdohG0J1ED41bMxSt2w2CMqeIYaDUMa8/iAfyVv8HW9FV/DsuBHbvqZRNknqqANeh45LePfBHvLIrk7YuLgrFu0wXgoj5Nmm45uVEm2Lf9WhmAUsgXycbEN/k5CutkXkJ+SDdodPoCT6ekiCMDZXhMSuyxRd1RXKLu1GFyo+GZLdTNRu9Lhgua5Asbm6TB4wGqiLA+Up9Jgi39Afl2DGMywzWoZdiyL3XRlxFYSOIHDrFAYWPx/XML+1JQePq8K3k6zt0l5T87XG8VZJ2aWdgtdmTvgrUb4PfgUIJbxL35t0bYmvFoI4Hff1GyA5tchmdxPaC1Uc7xeOtH6MCrpuk= koush@hgdlaptop01"
}

# data "azurerm_resource_group" "resource_group" {
#   name     = var.resource_group_name
#   location = var.resource_group_location
# }
#resource "azurerm_public_ip" "public_ip" {
 # name                = var.public_ip_name
  #resource_group_name = var.resource_group_name
  #location            = var.resource_group_location
  #allocation_method   = "Dynamic"
#}

resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
   # public_ip_address_id          = azurerm_public_ip.public_ip.id

  }
}

resource "azurerm_linux_virtual_machine" "ubuntu_linux_server" { # reference name in terrafom
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]
  disable_password_authentication = true

 admin_ssh_key {
   username   = var.username
 #public_key = file("C:/Users/koush/.ssh/id_rsa.pub")
    public_key = local.first_public_key

}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
