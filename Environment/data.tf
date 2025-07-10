# data "azurerm_key_vault" "kv" {
#   depends_on          = [module.resource_group]
#   name                = "ak-user-kv"
#   resource_group_name = "rg-akaushik"
# }

# data "azurerm_key_vault_secret" "admin_user" {
#   name         = "vm-user"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "admin_pass" {
#   name         = "vm-password"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }
