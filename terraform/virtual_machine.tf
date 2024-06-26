## Virtual Machine web app
resource "azurerm_linux_virtual_machine" "web" {
  name                  = "${var.prefix}-vm-web-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.tfazrg.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.web_app_intf.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = data.azurerm_key_vault_secret.sshKey-web.value
  }

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
}

resource "azurerm_linux_virtual_machine" "mgnmt_vm" {
  name                  = "${var.prefix}-mgmt-vm-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.tfazrg.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.mgmt_vm.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = data.azurerm_key_vault_secret.sshKey-mgmt.value
  }

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
}