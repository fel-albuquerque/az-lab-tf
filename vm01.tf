resource "azurerm_network_interface" "nic" {
  name                = "win-nic-vms01-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  enable_accelerated_networking = true
  enable_ip_forwarding          = false

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet_ad.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows" {
  name                = "VM-WIN-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.zone_us
  size                = "Standard_F2"
  admin_username      = "userazure"
  admin_password      = "@LabAZ@2022"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
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
}