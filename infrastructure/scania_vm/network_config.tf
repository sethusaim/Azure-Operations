resource "azurerm_virtual_network" "scania_network" {
  name                = var.scania_virtual_network_name
  address_space       = var.scania_virtual_network_address_space
  location            = var.scania_location
  resource_group_name = var.scania_resouce_group_name
}

resource "azurerm_subnet" "scania_subnet" {
  name                 = var.scania_subnet_name
  resource_group_name  = var.scania_resouce_group_name
  virtual_network_name = azurerm_virtual_network.scania_network.name
  address_prefixes     = var.scania_address_prefixes
}

resource "azurerm_public_ip" "scania_public_ip" {
  name                = var.scania_public_ip_name
  location            = var.scania_location
  resource_group_name = var.scania_resouce_group_name
  allocation_method   = var.scania_public_ip_allocation_method
}

resource "azurerm_network_security_group" "scania_nsg" {
  name                = var.scania_network_sg_name
  location            = var.scania_location
  resource_group_name = var.scania_resouce_group_name

  security_rule {
    name                       = var.scania_security_rule_name
    priority                   = var.scania_security_rule_priority
    direction                  = var.scania_security_rule_direction
    access                     = var.scania_security_rule_access
    protocol                   = var.scania_security_rule_protocol
    source_port_range          = var.scania_security_rule_source_port_range
    destination_port_range     = var.scania_security_rule_dest_port_range
    source_address_prefix      = var.scania_source_address_prefix
    destination_address_prefix = var.scania_dest_address_prefix
  }
}

resource "azurerm_network_interface" "scania_nic" {
  name                = var.scania_network_interface_name
  location            = var.scania_location
  resource_group_name = var.scania_resouce_group_name

  ip_configuration {
    name                          = var.scania_nic_ip_config_name
    subnet_id                     = azurerm_subnet.scania_subnet.id
    private_ip_address_allocation = var.scania_nic_private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.scania_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "scania_nic_sga" {
  network_interface_id      = azurerm_network_interface.scania_nic.id
  network_security_group_id = azurerm_network_security_group.scania_nsg.id
}