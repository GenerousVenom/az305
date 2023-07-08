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

resource "azurerm_public_ip" "tf-thinh-pubipwin" {
  name                = "tf-thinh-pubipwin"
  resource_group_name = var.name_of_rsg
  location            = var.name_of_location
  allocation_method   = "Static"
  domain_name_label = "tf-thinh-windm"
}

resource "azurerm_network_interface" "tf-thinh-netintwin" {
  name                = "tf-thinh-netintwin"
  location            = var.name_of_location
  resource_group_name = var.name_of_rsg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-thinh-subwin.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.tf-thinh-pubipwin.id
  }

  depends_on = [ 
    azurerm_subnet.tf-thinh-subwin
  ]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.tf-thinh-netintwin.id
  network_security_group_id = azurerm_network_security_group.tf-nw-secgrp.id
  depends_on = [ 
    azurerm_network_interface.tf-thinh-netintwin,
    azurerm_network_security_group.tf-nw-secgrp
  ]
}

resource "azurerm_windows_virtual_machine" "tf-thinh-vmwin" {
  name                = "tf-thinh-vmwin"
  resource_group_name = var.name_of_rsg
  location            = var.name_of_location
  size                = "Standard_D2s_v3"
  admin_username      = "thinhphung"
  admin_password      = "123qwe!@#QWE"
  network_interface_ids = [
    azurerm_network_interface.tf-thinh-netintwin.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  
  depends_on = [ 
    azurerm_network_interface.tf-thinh-netintwin
  ]
}