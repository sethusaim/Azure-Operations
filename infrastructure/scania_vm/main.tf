resource "azurerm_linux_virtual_machine" "scania_vm" {
  name                  = var.scania_vm_name
  location              = var.scania_location
  resource_group_name   = var.scania_resouce_group_name
  network_interface_ids = [azurerm_network_interface.scania_nic.id]
  size                  = var.scania_vm_size

  os_disk {
    name                 = var.scania_os_disk_name
    caching              = var.scania_os_disk_caching
    storage_account_type = var.scania_os_disk_sa_type
  }

  source_image_reference {
    publisher = var.scania_vm_image_publisher
    offer     = var.scania_vm_image_offer
    sku       = var.scania_vm_image_sku
    version   = var.scania_vm_image_version
  }

  computer_name  = var.scania_vm_computer_name
  admin_username = var.scania_vm_ssh_username

  admin_ssh_key {
    username   = var.scania_vm_ssh_username
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }

  depends_on = [
    tls_private_key.example_ssh
  ]
}


resource "azurerm_storage_account" "my_storage_account" {
  name                     = var.scania_boot_diag_sa_name
  location                 = var.scania_location
  resource_group_name      = var.scania_resouce_group_name
  account_tier             = var.scania_sa_account_tier
  account_replication_type = var.scania_account_replication_type
}

