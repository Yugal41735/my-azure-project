provider "azurerm" {
  features {}
  subscription_id = "80d37f3a-a7f6-405b-a0d0-e2d362572306"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "my-tfstate-rg"
    storage_account_name = "mytfstate12345"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "East US"
}

module "sql_server" {
  source              = "./modules/sql-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

module "sql_database" {
  source              = "./modules/sql-database"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sql_server_name     = module.sql_server.sql_server_name
}

module "linux_vm" {
  source              = "./modules/linux-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_count            = 2
}
