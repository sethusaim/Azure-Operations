resource "azurerm_virtual_network" "my_network" {
  name                = var.my_virtual_network_name
  address_space       = var.my_virtual_network_address_space
  location            = var.my_location
  resource_group_name = var.my_resouce_group_name
}

resource "azurerm_subnet" "my_subnet" {
  name                 = var.my_subnet_name
  resource_group_name  = var.my_resouce_group_name
  virtual_network_name = azurerm_virtual_network.my_network.name
  address_prefixes     = var.my_address_prefixes
}

resource "azurerm_public_ip" "my_public_ip" {
  name                = var.my_public_ip_name
  location            = var.my_location
  resource_group_name = var.my_resouce_group_name
  allocation_method   = var.my_public_ip_allocation_method
}

resource "azurerm_network_security_group" "my_nsg" {
  name                = var.my_network_sg_name
  location            = var.my_location
  resource_group_name = var.my_resouce_group_name

  security_rule {
    name                       = var.my_security_rule_name
    priority                   = var.my_security_rule_priority
    direction                  = var.my_security_rule_direction
    access                     = var.my_security_rule_access
    protocol                   = var.my_security_rule_protocol
    source_port_range          = var.my_security_rule_source_port_range
    destination_port_range     = var.my_security_rule_dest_port_range
    source_address_prefix      = var.my_source_address_prefix
    destination_address_prefix = var.my_dest_address_prefix
  }
}

resource "azurerm_network_interface" "my_nic" {
  name                = var.my_network_interface_name
  location            = var.my_location
  resource_group_name = var.my_resouce_group_name

  ip_configuration {
    name                          = var.my_nic_ip_config_name
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = var.my_nic_private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "my_nic_sga" {
  network_interface_id      = azurerm_network_interface.my_nic.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}