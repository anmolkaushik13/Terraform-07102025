module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = "rg-akaushik"
  location = "east us2"
}

module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = "rg-anmol-sharma"
  location = "east us2"
}

module "virtual_network" {
  source        = "../modules/azurerm_vnet"
  depends_on    = [module.resource_group]
  vnet_name     = "ak-vnet"
  rg_name       = "rg-akaushik"
  location      = "east us2"
  address_space = ["10.0.0.0/16"]
}

module "subnet" {
  source           = "../modules/azurerm_subnet"
  depends_on       = [module.virtual_network]
  subnet_name      = "ak-subnet"
  vnet_name        = "ak-vnet"
  rg_name          = "rg-akaushik"
  address_prefixes = ["10.0.1.0/24"]
}

module "public_ip" {
  source     = "../modules/azurerm_public_ip"
  depends_on = [module.resource_group]
  ip_name    = "ak-ip"
  location   = "east us2"
  rg_name    = "rg-akaushik"
}

module "vm" {
  source         = "../modules/azurerm_vm"
  depends_on     = [module.public_ip, module.subnet, module.virtual_network, module.keyvault, module.resource_group,module.secret_password,module.secret_username]
  rg_name        = "rg-akaushik"
  location       = "east us2"
  vm_name        = "ak-vm"
  vnet           = "ak-vnet"
  nic            = "ak-nic"
  subnet_name    = "ak-subnet"
  pip_name       = "ak-ip"
}


module "sql_server" {
  source              = "../modules/azurerm_sql_server"
  depends_on          = [module.resource_group, module.secret_password,module.secret_username]
  name                = "ak-server"
  location            = "east us2"
  rg_name             = "rg-akaushik"
}

module "sql_database" {
  depends_on  = [module.resource_group, module.sql_server]
  source      = "../modules/azurerm_database"
  name        = "ak-database"
  server_name = "ak-server"
  rg_name     = "rg-akaushik"
}

module "keyvault" {

  source       = "../modules/azurerm_key_vault"
  depends_on   = [module.resource_group]
  name         = "ak-as"
  location     = "east us2"
  rg_name      = "rg-akaushik"
}


module "secret_username" {
  source       = "../modules/azurerm_key_vault_secrets"
  depends_on   = [module.keyvault]
  kv_name      = "ak-as"
  rg_name      = "rg-akaushik"
  secret_name  = "vm-as"
  secret_value = "anmolas"
}

module "secret_password" {
  source       = "../modules/azurerm_key_vault_secrets"
  depends_on   = [module.keyvault]
  kv_name      = "ak-as"
  rg_name      = "rg-akaushik"
  secret_name  = "vm-password-as"
  secret_value = "UserP@ss123!!"
}
