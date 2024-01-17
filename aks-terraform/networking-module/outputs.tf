variable "resource_group_name" {
  description = "Name of the Azure resource group"
  value = azurerm_resource_group.networking.name
}

variable "vnet_id" {
  description = "ID of the Azure Virtual Network"
  value = azurerm_virtual_network.aks_vnet.id
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet"
  value = azurerm_subnet.control_plane_subnet.id
}

variable "worker_node_subnet_id" {
  description = "ID of the worker node subnet"
  value = azurerm_subnet.worker_node_subnet.id
}