resource "azurerm_service_plan" "my_service_plan" {
  name                = var.webapp_service_plan_name
  resource_group_name = module.container_registry.my_resoure_group_name
  location            = module.container_registry.my_resoure_group_location
  os_type             = var.webapp_os_type
  sku_name            = var.webapp_sku_name
}
