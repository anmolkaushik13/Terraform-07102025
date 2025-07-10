resource "azurerm_mssql_database" "database" {
  name = var.name
  server_id = data.azurerm_mssql_server.sql_server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name = "S0"
  enclave_type = "VBS"
  max_size_gb = 2
  license_type = "LicenseIncluded"
}