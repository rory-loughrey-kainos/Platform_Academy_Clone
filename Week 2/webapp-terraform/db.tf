# postgres
resource "azurerm_postgresql_server" "db_server" {
  name                = "${var.root_name}postgresql"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = "psqladmin"
  administrator_login_password = "DefaultPassword123"

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 30
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "db" {
  name                = "${var.root_name}psql-webapp-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.db_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}