resource "azurerm_resource_group" "scania_resource_group" {
  name     = var.scania_resource_group_name
  location = var.scania_location
}