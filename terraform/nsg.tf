## NSG for SSH | Web app VM
resource "azurerm_network_security_group" "sshAllow" {
  name                = "${var.prefix}-nsg-webapp-intf-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  security_rule {
    name                       = "${var.prefix}-ssh-rule-${var.env}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

## NSG Association
resource "azurerm_subnet_network_security_group_association" "sshAllowAssoc" {
  subnet_id                 = azurerm_subnet.spokesub01.id
  network_security_group_id = azurerm_network_security_group.sshAllow.id
}

resource "azurerm_network_security_group" "mgmt_vm_nsg" {
  name                = "${var.prefix}-nsg-mgmt-vm-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

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

  security_rule {
    name                       = "Deny-All-Inbound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-All-Outbound"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "mgmt_vm_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.mgmt_vm.id
  network_security_group_id = azurerm_network_security_group.mgmt_vm_nsg.id
}
