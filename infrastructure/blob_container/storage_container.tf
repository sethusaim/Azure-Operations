resource "azurerm_storage_container" "my_storager_container" {
  name                  = var.my_storage_container_name
  storage_account_name  = azurerm_storage_account.my_storage_account.name
  container_access_type = var.my_container_access_type
}