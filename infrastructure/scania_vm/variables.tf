variable "scania_vm_name" {
  type    = string
  default = "ScaniaVM"
}

variable "scania_vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "scania_tls_private_key_rsa_bits" {
  type    = number
  default = 4096
}

variable "scania_tls_private_key_algorithm" {
  type    = string
  default = "RSA"
}

variable "scania_private_key_file_name" {
  type    = string
  default = "scania.pem"
}


variable "scania_os_disk_sa_type" {
  type    = string
  default = "Premium_LRS"
}

variable "scania_os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "scania_os_disk_name" {
  type    = string
  default = "ScaniaOsDisk"
}

variable "scania_vm_image_version" {
  type    = string
  default = "latest"
}

variable "scania_vm_image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "scania_vm_image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "scania_vm_image_publisher" {
  type    = string
  default = "Canonical"
}


variable "scania_vm_computer_name" {
  type    = string
  default = "ScaniaComputer"
}

variable "scania_vm_ssh_username" {
  type    = string
  default = "azureuser"
}

variable "scania_nic_private_ip_allocation" {
  type    = string
  default = "Dynamic"
}

variable "scania_nic_ip_config_name" {
  type    = string
  default = "scania_nic_ip_configuration"
}

variable "scania_network_interface_name" {
  type    = string
  default = "ScaniaNetworkInterface"
}

variable "scania_dest_address_prefix" {
  type    = string
  default = "*"
}

variable "scania_source_address_prefix" {
  type    = string
  default = "*"
}

variable "scania_security_rule_dest_port_range" {
  type    = string
  default = "22"
}

variable "scania_security_rule_source_port_range" {
  type    = string
  default = "*"
}

variable "scania_security_rule_protocol" {
  type    = string
  default = "Tcp"
}

variable "scania_security_rule_access" {
  type    = string
  default = "Allow"
}

variable "scania_security_rule_direction" {
  type    = string
  default = "Inbound"
}

variable "scania_security_rule_priority" {
  type    = number
  default = 1001
}

variable "scania_security_rule_name" {
  type    = string
  default = "Scania"
}

variable "scania_network_sg_name" {
  type    = string
  default = "ScaniaSecurityGroup"
}

variable "scania_public_ip_name" {
  type    = string
  default = "scaniapublicip"
}

variable "scania_public_ip_allocation_method" {
  type    = string
  default = "Dynamic"
}

variable "scania_subnet_name" {
  type    = string
  default = "scaniasubnet"
}

variable "scania_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}


variable "scania_virtual_network_name" {
  type    = string
  default = "scaniavirtualnetwork"
}

variable "scania_virtual_network_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "scania_location" {
  type    = string
  default = "eastus"
}

variable "scania_resouce_group_name" {
  type    = string
  default = "ScaniaRG"
}

variable "scania_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "scania_boot_diag_sa_name" {
  type    = string
  default = "scaniasa"
}

variable "scania_sa_account_tier" {
  type    = string
  default = "Standard"
}
