#subnet para o fw
resource "azurerm_subnet" "snet_fw1" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.254.0/24"]
}

#IP publico para o FW
resource "azurerm_public_ip" "pip_fw01" {
  name                = "pip-fw-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Firewall policy premium
resource "azurerm_firewall_policy" "pol_fw" {
  name                     = "pol-fw-lab01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.zone_us
  sku                      = "Premium"
  threat_intelligence_mode = "Alert"
}


## Configuração para o FW + policy premium 
resource "azurerm_firewall" "fw_az" {
  name                = "fw-${terraform.workspace}-01"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  firewall_policy_id  = azurerm_firewall_policy.pol_fw.id
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet_fw.id
    public_ip_address_id = azurerm_public_ip.pip_fw01.id
  }
}
