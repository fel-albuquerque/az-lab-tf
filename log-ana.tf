resource "azurerm_log_analytics_workspace" "log_ana" {
  name                = "log-ana-fw-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


resource "azurerm_log_analytics_workspace" "log_nsg" {
  name                = "log-ana-aks-${terraform.workspace}"
  location            = var.zone_us
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}