resource "azurerm_sql_database" "db" {
  name                = "my-database"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.sql_server_name
  edition             = "Basic"
}
