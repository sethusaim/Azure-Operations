resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.scania_resource_group.name
  location            = azurerm_resource_group.scania_resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
  georeplications {
    location                = "eastus"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "westeurope"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
