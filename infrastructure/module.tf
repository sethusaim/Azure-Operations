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

module "virtual_machine" {
  source = "./virtual_machine"
}

module "blob_container" {
  source = "./blob_container"
}

module "container_registry" {
  source = "./container_registry"
}

module "web_app" {
  source = "./web_app"
}