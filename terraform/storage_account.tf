resource "random_string" "storage_account_name" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "tfazstg" {
  name                     = lower("${var.prefix}stg${var.env}${random_string.storage_account_name.result}")
  resource_group_name      = azurerm_resource_group.tfazrg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "tfazcont-01" {
  name                 = "${var.prefix}-cont-${var.env}-01"
  storage_account_name = azurerm_storage_account.tfazstg.name
}