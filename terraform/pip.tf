## NIC Public IP web app vm
resource "azurerm_public_ip" "webapp_pip" {
  name                = "${var.prefix}-pip-vm01-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  allocation_method   = "Dynamic"
}

## PIP MGMT VM
resource "azurerm_public_ip" "mgmt_pip" {
  name                = "${var.prefix}-pip-mgmt-vm01-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  allocation_method   = "Dynamic"
}

## PIP Firewall
resource "azurerm_public_ip" "fwpip" {
  name                = "${var.prefix}-fwpip-${var.env}"
  location            = azurerm_resource_group.tfazrg.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}