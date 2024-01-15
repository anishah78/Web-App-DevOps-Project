variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group where networking resources will be deployed."
  default     = "defaultResourceGroup"  # Provided a default value
}

variable "location" {
  type        = string
  description = "Azure region where networking resources will be deployed."
  default     = "location"  # Provided a default value
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network (VNet)."
  default     = ["82.31.245.149"]  # Provided a default value for the source address
}

