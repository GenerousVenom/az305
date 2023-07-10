resource "azurerm_public_ip" "tf-thinh-pubipwin" {
  count = length(local.name_of_vm)
  name                = "tf-thinh-pubipwin-${local.name_of_vm[count.index]}"
  resource_group_name = var.name_of_rsg
  location            = var.name_of_location
  allocation_method   = "Static"
  domain_name_label = "tf-thinh-win-${local.name_of_vm[count.index]}"
}

resource "azurerm_network_interface" "tf-thinh-netintwin" {
  count = length(local.name_of_vm)
  name                = "tf-thinh-netintwin-${local.name_of_vm[count.index]}"
  location            = var.name_of_location
  resource_group_name = var.name_of_rsg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-thinh-subwin.id
    private_ip_address_allocation = "Static"
    private_ip_address = local.private_ip_address[count.index]
    public_ip_address_id = azurerm_public_ip.tf-thinh-pubipwin[count.index].id
  }

  depends_on = [ 
    azurerm_subnet.tf-thinh-subwin
  ]
}

resource "azurerm_network_interface_security_group_association" "example" {
  count = length(local.name_of_vm)
  network_interface_id      = azurerm_network_interface.tf-thinh-netintwin[count.index].id
  network_security_group_id = azurerm_network_security_group.tf-nw-secgrp.id
  depends_on = [ 
    azurerm_network_interface.tf-thinh-netintwin,
    azurerm_network_security_group.tf-nw-secgrp
  ]
}

resource "azurerm_windows_virtual_machine" "tf-thinh-vmwin" {
  count = length(local.name_of_vm)
  name                = "tf-thinh-vm-${local.name_of_vm[count.index]}"
  resource_group_name = var.name_of_rsg
  location            = var.name_of_location
  size                = "Standard_DS1_v2"
  admin_username      = "thinhphung"
  admin_password      = "123qwe!@#QWE"
  network_interface_ids = [
    azurerm_network_interface.tf-thinh-netintwin[count.index].id,
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