## VNet Hub Subnet
resource "azurerm_subnet" "hubsub" {
  name                 = "${var.prefix}-hub-sub-${var.env}"
  resource_group_name  = azurerm_resource_group.tfazrg.name
  virtual_network_name = azurerm_virtual_network.tfazvnethub.name
  address_prefixes     = ["10.0.1.0/24"]
}

####### Spoke subnets

## Spoke Subnet01
resource "azurerm_subnet" "spokesub01" {
  name                 = "${var.prefix}-spoke-sub01-${var.env}"
  resource_group_name  = azurerm_resource_group.tfazrg.name
  virtual_network_name = azurerm_virtual_network.spoke01.name
  address_prefixes     = ["10.1.1.0/24"]
}

## Spoke Subnet02
resource "azurerm_subnet" "spokesub02" {
  name                 = "${var.prefix}-spoke-sub02-${var.env}"
  resource_group_name  = azurerm_resource_group.tfazrg.name
  virtual_network_name = azurerm_virtual_network.spoke02.name
  address_prefixes     = ["10.2.1.0/24"]
}

## Firewall subnet
resource "azurerm_subnet" "fwsub" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.tfazrg.name
  virtual_network_name = azurerm_virtual_network.tfazvnethub.name
  address_prefixes     = ["10.0.2.0/26"]
}