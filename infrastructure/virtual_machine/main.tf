module "resource_group" {
  source = "../resource_group"
}

resource "azurerm_linux_virtual_machine" "my_vm" {
  name                  = var.my_vm_name
  location              = module.resource_group.my_resoure_group_location
  resource_group_name   = module.resource_group.my_resoure_group_name
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  size                  = var.my_vm_size

  os_disk {
    name                 = var.my_os_disk_name
    caching              = var.my_os_disk_caching
    storage_account_type = var.my_os_disk_sa_type
  }

  source_image_reference {
    publisher = var.my_vm_image_publisher
    offer     = var.my_vm_image_offer
    sku       = var.my_vm_image_sku
    version   = var.my_vm_image_version
  }

  computer_name  = var.my_vm_computer_name
  admin_username = var.my_vm_ssh_username

  admin_ssh_key {
    username   = var.my_vm_ssh_username
    public_key = tls_private_key.my_private_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }

  depends_on = [
    tls_private_key.my_private_key
  ]
}


resource "azurerm_storage_account" "my_storage_account" {
  name                     = var.my_boot_diag_sa_name
  location                 = module.resource_group.my_resoure_group_location
  resource_group_name      = module.resource_group.my_resoure_group_name
  account_tier             = var.my_sa_account_tier
  account_replication_type = var.my_account_replication_type
}

