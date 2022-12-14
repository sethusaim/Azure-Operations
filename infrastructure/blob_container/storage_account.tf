module "resource_group" {
  source = "../resource_group"
}

resource "azurerm_storage_account" "my_storage_account" {
  name                     = var.my_storage_account_name
  resource_group_name      = module.resource_group.my_resoure_group_name
  location                 = module.resource_group.my_resoure_group_location
  account_tier             = var.my_account_tier
  account_replication_type = var.my_account_replication_type
}
