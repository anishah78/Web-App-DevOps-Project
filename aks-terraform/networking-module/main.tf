resource "azurerm_resource_group" "networking" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "azurerm_virtual_network"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}
resource "azurerm_subnet" "control_plane_subnet" {
  name                 = "azurerm_control_plane_subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "worker_node_subnet" {
  name                 = "azurerm_worker_node_subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "azurerm_security_group"
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}
resource "azurerm_network_security_rule" "kube_apiserver" {
  name                        = "network_security_kube_apiserver"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "82.31.245.149"  # Replaced with the public IP 
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}
resource "azurerm_network_security_rule" "ssh" {
  name                        = "allow_ssh_inbound"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "82.31.245.149"  # Replaced with the public IP
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}
