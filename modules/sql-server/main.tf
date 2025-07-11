resource "azurerm_sql_server" "sql" {
  name                         = "my-sql-server-${random_string.suffix.result}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "SuperSecret123!"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

output "sql_server_name" {
  value = azurerm_sql_server.sql.name
}
