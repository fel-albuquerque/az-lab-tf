resource "azurerm_route_table" "rt_fw" {
  name                          = "route-internet"
  location                      = var.zone_us
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = true

  route {
    name                   = "rt-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "192.168.254.4"

  }

  route {
    name                   = "rt-spoke01"
    address_prefix         = "10.10.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "192.168.254.4"

  }


  route {
    name                   = "rt-spoke02"
    address_prefix         = "172.16.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "192.168.254.4"

  }
}

resource "azurerm_subnet_route_table_association" "ass_hub" {
  subnet_id      = azurerm_subnet.snet_dados.id
  route_table_id = azurerm_route_table.rt_fw.id
}

resource "azurerm_subnet_route_table_association" "ass_spoke01" {
  subnet_id      = azurerm_subnet.snet_aks_node.id
  route_table_id = azurerm_route_table.rt_fw.id
}