variable "my_vm_name" {
  type    = string
  default = "myVM"
}

variable "my_vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "my_tls_private_key_rsa_bits" {
  type    = number
  default = 4096
}

variable "my_tls_private_key_algorithm" {
  type    = string
  default = "RSA"
}

variable "my_private_key_file_name" {
  type    = string
  default = "my.pem"
}


variable "my_os_disk_sa_type" {
  type    = string
  default = "Premium_LRS"
}

variable "my_os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "my_os_disk_name" {
  type    = string
  default = "myOsDisk"
}

variable "my_vm_image_version" {
  type    = string
  default = "latest"
}

variable "my_vm_image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "my_vm_image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "my_vm_image_publisher" {
  type    = string
  default = "Canonical"
}


variable "my_vm_computer_name" {
  type    = string
  default = "myComputer"
}

variable "my_vm_ssh_username" {
  type    = string
  default = "azureuser"
}

variable "my_nic_private_ip_allocation" {
  type    = string
  default = "Dynamic"
}

variable "my_nic_ip_config_name" {
  type    = string
  default = "my_nic_ip_configuration"
}

variable "my_network_interface_name" {
  type    = string
  default = "myNetworkInterface"
}

variable "my_dest_address_prefix" {
  type    = string
  default = "*"
}

variable "my_source_address_prefix" {
  type    = string
  default = "*"
}

variable "my_security_rule_dest_port_range" {
  type    = string
  default = "22"
}

variable "my_security_rule_source_port_range" {
  type    = string
  default = "*"
}

variable "my_security_rule_protocol" {
  type    = string
  default = "Tcp"
}

variable "my_security_rule_access" {
  type    = string
  default = "Allow"
}

variable "my_security_rule_direction" {
  type    = string
  default = "Inbound"
}

variable "my_security_rule_priority" {
  type    = number
  default = 1001
}

variable "my_security_rule_name" {
  type    = string
  default = "my"
}

variable "my_network_sg_name" {
  type    = string
  default = "mySecurityGroup"
}

variable "my_public_ip_name" {
  type    = string
  default = "mypublicip"
}

variable "my_public_ip_allocation_method" {
  type    = string
  default = "Dynamic"
}

variable "my_subnet_name" {
  type    = string
  default = "mysubnet"
}

variable "my_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}


variable "my_virtual_network_name" {
  type    = string
  default = "myvirtualnetwork"
}

variable "my_virtual_network_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "my_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "my_boot_diag_sa_name" {
  type    = string
  default = "mysa"
}

variable "my_sa_account_tier" {
  type    = string
  default = "Standard"
}
