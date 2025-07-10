data "azurerm_subnet" "subnet" {
 name = var.subnet_name
 resource_group_name = var.rg_name
 virtual_network_name = var.vnet
}

data "azurerm_public_ip" "pip"{
    name = var.pip_name
    resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  # depends_on          = [module.resource_group]
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