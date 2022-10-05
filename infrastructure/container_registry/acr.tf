resource "azurerm_container_registry" "my_acr" {
  name                = var.my_acr_name
  resource_group_name = var.my_resource_group_name
  location            = var.my_resource_group_location
  sku                 = var.my_acr_sku
}
