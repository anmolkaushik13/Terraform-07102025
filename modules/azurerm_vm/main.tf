resource "azurerm_network_interface" "nic"{
    name = var.nic
    resource_group_name = var.rg_name
    location = var.location

    ip_configuration {
      public_ip_address_id = data.azurerm_public_ip.pip.id
      private_ip_address_allocation = "Dynamic"
      name = "internal"
      subnet_id = data.azurerm_subnet.subnet.id
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  location = var.location
  resource_group_name = var.rg_name
  size = "Standard_B1s"
  admin_password = data.azurerm_key_vault_secret.admin_pass.value
  admin_username = data.azurerm_key_vault_secret.admin_user.value
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id, ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
  source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }    

}