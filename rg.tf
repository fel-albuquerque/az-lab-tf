resource "azurerm_resource_group" "rg" {
  name     = "rg-${terraform.workspace}-hub-spoke"
  location = var.zone_us
}