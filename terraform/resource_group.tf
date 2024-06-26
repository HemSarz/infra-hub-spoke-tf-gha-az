## Resource Group
resource "azurerm_resource_group" "tfazrg" {
  name     = "${var.prefix}-rg-${var.env}"
  location = var.location
}