resource "azurerm_resource_group" "tf-rsg" {
  name     = var.name_of_rsg
  location = var.name_of_location
}

resource "azurerm_virtual_network" "tf-vnet" {
  name                = var.name_of_vnet
  address_space       = [var.vnet_address_space]
  location            = var.name_of_location
  resource_group_name = var.name_of_rsg
  depends_on = [ 
    azurerm_resource_group.tf-rsg
  ]
  dns_servers = ["10.10.10.10"]
}
