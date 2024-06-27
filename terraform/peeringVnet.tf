#### VNET Peering | Hub & Spoke 

# Peering between Hub and Spoke01
resource "azurerm_virtual_network_peering" "hub_to_spoke01" {
  name                      = "${var.prefix}-hub-to-spoke01-peering-${var.env}"
  resource_group_name       = azurerm_resource_group.tfazrg.name
  virtual_network_name      = azurerm_virtual_network.tfazvnethub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke01.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false

  depends_on = [
    azurerm_virtual_network.tfazvnethub,
    azurerm_virtual_network.spoke01
  ]
}

# Peering between Spoke01 and Hub
resource "azurerm_virtual_network_peering" "spoke01_to_hub" {
  name                      = "${var.prefix}-spoke01-to-hub-${var.env}"
  resource_group_name       = azurerm_resource_group.tfazrg.name
  virtual_network_name      = azurerm_virtual_network.spoke01.name
  remote_virtual_network_id = azurerm_virtual_network.tfazvnethub.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false

  depends_on = [
    azurerm_virtual_network.spoke01,
    azurerm_virtual_network.tfazvnethub
  ]
}

# Peering between Hub and Spoke02
resource "azurerm_virtual_network_peering" "hub_to_spoke02" {
  name                      = "${var.prefix}-hub-to-spoke02-${var.env}"
  resource_group_name       = azurerm_resource_group.tfazrg.name
  virtual_network_name      = azurerm_virtual_network.tfazvnethub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke02.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false

  depends_on = [
    azurerm_virtual_network.tfazvnethub,
    azurerm_virtual_network.spoke02
  ]
}

# Peering between Spoke02 and Hub
resource "azurerm_virtual_network_peering" "spoke02_to_hub" {
  name                      = "${var.prefix}-spoke02-to-hub-${var.env}"
  resource_group_name       = azurerm_resource_group.tfazrg.name
  virtual_network_name      = azurerm_virtual_network.spoke02.name
  remote_virtual_network_id = azurerm_virtual_network.tfazvnethub.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false

  depends_on = [
    azurerm_virtual_network.spoke02,
    azurerm_virtual_network.tfazvnethub
  ]
}
