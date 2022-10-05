terraform {
  backend "azurerm" {
    resource_group_name  = "scaniatfstate"
    storage_account_name = "scaniatfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./scania_resource_group"
}

module "virtual_machine" {
  source = "./scania_vm"
  depends_on = [
    module.resource_group
  ]
}

module "io_files_container" {
  source = "./scania_io_files_container"
  depends_on = [
    module.resource_group
  ]
}

# module "acr" {
#   source = "./scania_acr"
#   depends_on = [
#     module.resource_group
#   ]
# }
