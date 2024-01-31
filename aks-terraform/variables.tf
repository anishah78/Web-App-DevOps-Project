variable "service_principal_client_id" {
  description = "Client ID for the service principal associated with the cluster"  #included output variable for input variables in aks_cluster
  type        = string
}

variable "service_principal_client_secret" {
  description = "Client Secret for the service principal associated with the cluster"
  type        = string
}

variable "tenant_id" {
    description = "Tenant id associated with the cluster"
    type        = string 
}

variable "Ip_address" {
  type        = string
  description = "Address space for the Virtual Network (VNet)."
}
