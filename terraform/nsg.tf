## NSG for RDP | MGMT VM
resource "azurerm_network_security_group" "RDPDeny" {
  name                = "${var.prefix}-nsg-webapp-intf-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  security_rule {
    name                       = "${var.prefix}-RDP-nsg-mgmt-vm-${var.env}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

## NSG Association MGMT
resource "azurerm_subnet_network_security_group_association" "RDPDeny" {
  subnet_id                 = azurerm_subnet.spokesub02.id
  network_security_group_id = azurerm_network_security_group.RDPDeny.id
}

#### NSG for RDP | Web app VM
resource "azurerm_network_security_group" "RDPAllow" {
  name                = "${var.prefix}-nsg-web-vm-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "web_vm_nsg_assoc" {
  subnet_id                 = azurerm_subnet.spokesub01.id
  network_security_group_id = azurerm_network_security_group.RDPDeny.id

}