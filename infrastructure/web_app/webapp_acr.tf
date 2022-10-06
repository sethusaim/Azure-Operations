resource "azurerm_container_registry" "my_webapp_acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  admin_enabled       = var.container_registry_admin_enabled
  sku                 = var.container_registry_sku
}
