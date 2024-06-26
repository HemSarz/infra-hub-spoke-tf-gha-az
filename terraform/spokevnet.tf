################## Spoke VNETs

##Spoke01
resource "azurerm_virtual_network" "spoke01" {
  name                = "${var.prefix}-spoke-vnet01-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  address_space       = ["10.1.0.0/16"]
}

##Spoke02
resource "azurerm_virtual_network" "spoke02" {
  name                = "${var.prefix}-spoke-vnet02-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  address_space       = ["10.2.0.0/24"]
}