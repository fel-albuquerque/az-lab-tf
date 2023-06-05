resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet-hub-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "snet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.1.224/27"]
}

resource "azurerm_subnet" "snet_fw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.254.0/24"]
}

resource "azurerm_subnet" "snet_gws" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.253.0/27"]
}

resource "azurerm_subnet" "snet_ad" {
  name                 = "snet-ad-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["192.168.10.0/24"]
}

resource "azurerm_virtual_network" "vnet_spoke01" {
  name                = "vnet-spoke01-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "snet_srv" {
  name                 = "snet-srv-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke01.name
  address_prefixes     = ["10.10.0.0/24"]
}


resource "azurerm_virtual_network" "vnet_spoke02" {
  name                = "vnet-spoke02-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["172.16.0.0/16"]
}

resource "azurerm_subnet" "snet_dados" {
  name                 = "snet-dados-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke02.name
  address_prefixes     = ["172.16.0.0/24"]
}

resource "azurerm_subnet" "snet_aks_node" {
  name                 = "snet-node-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke02.name
  address_prefixes     = ["172.16.8.0/21"]
}

resource "azurerm_subnet" "snet_aks_pod" {
  name                 = "snet-pod-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke02.name
  address_prefixes     = ["172.16.16.0/21"]
}

resource "azurerm_virtual_network_peering" "vnet_hub" {
  name                      = "peer-vnet-hub-to-vnet-spoke01"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke01.id
}

resource "azurerm_virtual_network_peering" "vnet_spoke01" {
  name                      = "peer-vnet-spoke01-to-vnet-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}

resource "azurerm_virtual_network_peering" "vnet_hub2" {
  name                      = "peer-vnet-hub-to-vnet-spoke02"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke02.id
}


resource "azurerm_virtual_network_peering" "vnet_spoke02" {
  name                      = "peer-vnet-spoke02-to-vnet-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke02.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}