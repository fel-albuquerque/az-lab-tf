resource "azurerm_public_ip" "public_ip" {
  name                = "jump_public_ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.zone_us
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic_jump" {
  name                = "win-wmsjump1"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  enable_accelerated_networking = true
  enable_ip_forwarding          = false

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet_ad.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "windows3" {
  name                = "VM-WIN-JUMP1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.zone_us
  size                = "Standard_F2"
  admin_username      = "userazure"
  admin_password      = "@LabAZ@2022"
  network_interface_ids = [
    azurerm_network_interface.nic_jump.id,
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
