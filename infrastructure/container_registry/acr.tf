module "resource_group" {
  source = "../resource_group"
}

resource "azurerm_container_registry" "my_acr" {
  name                = var.my_acr_name
  resource_group_name = module.resource_group.my_resoure_group_name
  location            = module.resource_group.my_resoure_group_location
  admin_enabled       = var.my_acr_admin_enabled
  sku                 = var.my_acr_sku
}

output "my_resoure_group_name" {
  value = module.resource_group.my_resoure_group_name
}

output "my_resoure_group_location" {
  value = module.resource_group.my_resoure_group_location
}

output "my_webapp_acr_login_server" {
  value = azurerm_container_registry.my_acr.login_server
}

output "my_webapp_acr_admin_username" {
  value = azurerm_container_registry.my_acr.admin_username
}

output "my_webapp_acr_admin_password" {
  value = azurerm_container_registry.my_acr.admin_password
}
