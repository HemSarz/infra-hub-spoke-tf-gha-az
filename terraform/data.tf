data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "tfazrgbackend" {
  name = "tfaz-bcknd-rg"
}

data "azuread_service_principal" "tfazsp" {
  display_name = "tfazspnbcknd"
}

data "azurerm_storage_account" "bckndstg" {
  name                = "backndtfazstg01"
  resource_group_name = data.azurerm_resource_group.tfazrgbackend.name
}