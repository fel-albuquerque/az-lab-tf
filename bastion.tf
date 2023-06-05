resource "azurerm_public_ip" "pip_bst" {
  name                = "pip-bst"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bst_host" {
  name                = "bst-hub"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet_bastion.id
    public_ip_address_id = azurerm_public_ip.pip_bst.id
  }
}