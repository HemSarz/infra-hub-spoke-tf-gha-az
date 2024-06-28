## Virtual Machine Web App
resource "azurerm_linux_virtual_machine" "web-vm" {
  name                  = "${var.prefix}-vm-web-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.tfazrg.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  disable_password_authentication = false
  admin_password        = azurerm_key_vault_secret.vm-web-sec.value
  network_interface_ids = [azurerm_network_interface.web_app_intf.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [azurerm_key_vault_secret.vm-web-sec]
}

resource "azurerm_linux_virtual_machine" "mgnmt_vm" {
  name                  = "${var.prefix}-mgmt-vm-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.tfazrg.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = azurerm_key_vault_secret.vm-mgmt-sec.value
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.mgmt_vm.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [azurerm_key_vault_secret.vm-mgmt-sec]
}