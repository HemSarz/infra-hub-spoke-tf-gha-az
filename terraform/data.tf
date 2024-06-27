data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

/*data "azurerm_resource_group" "tfazrgbackend" {
  #name = "tfaz-bcknd-rg"
#}

data "azuread_service_principal" "tfazsp" {
  display_name = "tfazspnbcknd"
}

data "azurerm_storage_account" "bckndstg" {
  name                = "backndtfazstg01"
  resource_group_name = data.azurerm_resource_group.tfazrgbackend.name
}

data "azurerm_key_vault" "bckndKV" {
  name                = "bcknd-tfaz-kvault"
  resource_group_name = data.azurerm_resource_group.tfazrgbackend.name
}

#Fetch SSHKey
data "azurerm_key_vault_secret" "sshKey-web" {
  name         = "tfazlnxkeypub-web-vm"
  key_vault_id = data.azurerm_key_vault.bckndKV.id
}

data "azurerm_key_vault_secret" "sshKey-mgmt" {
  name         = "tfazlnxkeypub-mgmt-vm"
  key_vault_id = data.azurerm_key_vault.bckndKV.id
}

output "ssh_key-web" {
  value     = data.azurerm_key_vault_secret.sshKey-web.value
  sensitive = true
}

output "ssh_key-mgmt" {
  value     = data.azurerm_key_vault_secret.sshKey-mgmt.value
  sensitive = true
} */