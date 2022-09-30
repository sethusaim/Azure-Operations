terraform {
  backend "azurerm" {
    resource_group_name  = "sethutest"
    storage_account_name = "testsethu"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

module "io_files_container" {
  source = "./scania_io_files_container"
}

