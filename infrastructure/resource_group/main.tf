resource "azurerm_resource_group" "my_resoure_group" {
  name     = var.my_resoure_group_name
  location = var.my_resoure_group_location
}

output "my_resoure_group_name" {
  value = azurerm_resource_group.my_resoure_group.name
}

output "my_resoure_group_location" {
  value = azurerm_resource_group.my_resoure_group.location
}