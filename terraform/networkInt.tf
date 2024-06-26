## Network Interface web app
resource "azurerm_network_interface" "web_app_intf" {
  name                = "${var.prefix}-nic-web-app-vm01-${var.env}"
  location            = azurerm_resource_group.tfazrg.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  ip_configuration {
    name                          = "${var.prefix}-ipconfig-web-${var.env}"
    subnet_id                     = azurerm_subnet.spokesub01.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.1.20"
    public_ip_address_id          = azurerm_public_ip.webapp_pip.id
  }
}

## Network Interface mgmt
resource "azurerm_network_interface" "mgmt_vm" {
  name                = "${var.prefix}-nic-mgmt-vm01-${var.env}"
  location            = azurerm_resource_group.tfazrg.location
  resource_group_name = azurerm_resource_group.tfazrg.name

  ip_configuration {
    name                          = "${var.prefix}-ipconfig-mgmt-vm-${var.env}"
    subnet_id                     = azurerm_subnet.hubsub.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.20"
    public_ip_address_id          = azurerm_public_ip.mgmt_pip.id
  }
}