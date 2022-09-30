resource "azurerm_storage_account" "scania_storage_account" {
  name                     = var.scania_storage_account_name
  resource_group_name      = azurerm_resource_group.scania_resource_group.name
  location                 = azurerm_resource_group.scania_resource_group.location
  account_tier             = var.scania_account_tier
  account_replication_type = var.scania_account_replication_type
}