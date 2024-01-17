variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group where networking resources will be deployed."
  default     = "azurerm_resource_group.networking.name"  # Provided a default value
}

variable "location" {
  type        = string
  description = "Azure region where networking resources will be deployed."
  default     = "UK South"  # Provided a default value
}

variable "vnet_address_space" {
    description = "Address space for Virtual Network (VNet)"
    type = list(string)
    default = ["10.0.0.0/16"]
    
}