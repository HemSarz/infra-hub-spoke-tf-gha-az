
## Virtual Network
resource "azurerm_virtual_network" "tfazvnethub" {
  name                = "${var.prefix}-vnet-hub-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  address_space       = ["10.10.0.0/16"]
}