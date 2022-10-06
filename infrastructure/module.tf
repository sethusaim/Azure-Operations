terraform {
  backend "azurerm" {
    resource_group_name  = "mytfstate"
    storage_account_name = "mytfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./resource_group"
}

module "virtual_machine" {
  source = "./virtual_machine"
  depends_on = [
    module.resource_group
  ]
}

module "blob_container" {
  source = "./blob_container"
  depends_on = [
    module.resource_group
  ]
}

module "container_registry" {
  source = "./container_registry"
  depends_on = [
    module.resource_group
  ]
}
