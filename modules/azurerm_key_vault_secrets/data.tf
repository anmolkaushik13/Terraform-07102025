  data "azurerm_key_vault" "kv" {
    name                = var.kv_name
    resource_group_name = var.rg_name
  }