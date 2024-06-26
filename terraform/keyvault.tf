## KeyVault
resource "azurerm_key_vault" "tfazkv" {
  name                = "${var.prefix}-kv01-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name
}
