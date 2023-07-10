resource "azurerm_subnet" "tf-thinh-subwin" {
  name                 = "tf-thinh-subwin"
  resource_group_name  = var.name_of_rsg
  virtual_network_name = var.name_of_vnet
  address_prefixes     = [cidrsubnet(var.vnet_address_space, 8, 10)]
}

resource "azurerm_network_security_group" "tf-nw-secgrp" {
  name                = "tf-nw-secgrp"
  location            = var.name_of_location
  resource_group_name = var.name_of_rsg

  security_rule {
    name                       = "AllowAnyCustomIIS"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8172"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowRDP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowICMP"
    priority                   = 203
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}