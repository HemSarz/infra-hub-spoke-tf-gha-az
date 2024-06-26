## KeyVault
resource "azurerm_key_vault" "tfazkv" {
  name                     = "${var.prefix}-kv01-${var.env}"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.tfazrg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = var.sku_name
  purge_protection_enabled = false
}

/*## Grant SPN correct role
resource "azurerm_role_assignment" "spn_kv_role" {
  scope              = azurerm_key_vault.tfazkv.id
  role_definition_id = var.SPNRole
  principal_id       = data.azuread_service_principal.tfazsp.object_id
}*/

resource "azurerm_key_vault_access_policy" "SPN_Access" {
  key_vault_id = azurerm_key_vault.tfazkv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.tfazsp.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]

}

# VM Secrets

resource "random_password" "vm-web-rndm-sec" {
  length           = 12
  special          = true
  upper            = true
  lower            = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "vm-web-sec" {
  name         = "${var.prefix}-vm-web-sec-${var.env}"
  key_vault_id = azurerm_key_vault.tfazkv.id
  value        = random_password.vm-web-rndm-sec.result

  depends_on = [

    azurerm_key_vault_access_policy.SPN_Access,

  ]
}

resource "random_password" "vm-mgmt-rndm-sec" {
  length           = 12
  special          = true
  upper            = true
  lower            = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "vm-mgmt-sec" {
  name         = "${var.prefix}-vm-mgmt-sec-${var.env}"
  key_vault_id = azurerm_key_vault.tfazkv.id
  value        = random_password.vm-mgmt-rndm-sec.result

  depends_on = [

    azurerm_key_vault_access_policy.SPN_Access,
  ]
}