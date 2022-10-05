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
  source = "./my_resource_group"
}

module "virtual_machine" {
  source = "./my_vm"
  depends_on = [
    module.resource_group
  ]
}

module "blob_container" {
  source = "./my_io_files_container"
  depends_on = [
    module.resource_group
  ]
}

module "acr" {
  source = "./my_acr"
  depends_on = [
    module.resource_group
  ]
}