output "vnet_id" {
  description = "ID of the Virtual Network (VNet)"
  value  = azurerm_virtual_network.aks_vnet.id   #stored id of subnet within vnet to be deployed within AKS cluster
}

output "control_plane_subnet_id" {
  description = "ID of the control plane subnet."
  value       = azurerm_subnet.control_plane_subnet.id  #stored control control_plane_subnet within vnet to be deployed within AKS cluster
}

output "worker_node_subnet_id" {
  description = "ID of the worker node subnet."
  value       = azurerm_subnet.worker_node_subnet.id  #stored worker_node_subnet_id within vnet to be deployed within AKS cluster
}

output "resource_group_name" {
  description = "Name of the Azure Resource Group for networking resources."
  value       = azurerm_resource_group.networking.name          #stored resource_group_name subnet within vnet to be deployed within AKS cluster
}

# Define more output variables as needed...
output "aks_nsg_id" {
  description = "ID of the Network Security Group (NSG) for AKS."
  value       = azurerm_network_security_group.aks_nsg.id         #stored aks_nsg_id subnet within vnet to be deployed within AKS cluster
}