data "azurerm_key_vault" "kv" {
  name                = "ak-as"
  resource_group_name = "rg-akaushik"
}

data "azurerm_key_vault_secret" "admin_user" {
  name         = "vm-as"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "admin_pass" {
  name         = "vm-password-as"
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_mssql_server" "sql_server"{
    name = var.name
    resource_group_name = var.rg_name
    location = var.location
    administrator_login = data.azurerm_key_vault_secret.admin_user.value
    administrator_login_password = data.azurerm_key_vault_secret.admin_pass.value
    version = "12.0"
    
}

