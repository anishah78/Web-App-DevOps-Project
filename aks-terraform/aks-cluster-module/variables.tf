variable "aks_cluster_name" {
  description = "Name of the AKS cluster" #defined input variable to customise aks_cluster name
  type        = string
}

variable "cluster_location" {
  description = "Azure region where the AKS cluster will be deployed"     #defined input variable to customise aks_cluster location 
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix of the cluster"     #defined input variable to customise aks_cluster DNS prefix
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"     #defined input variable to customise aks_cluster kubernetes_version
  type        = string
}

variable "service_principal_client_id" {
  description = "Client ID for the service principal associated with the cluster"  #included output variable for input variables in aks_cluster
  type        = string
}

variable "service_principal_client_secret" {
  description = "Client Secret for the service principal associated with the cluster"
  type        = string
}

# included output variables from networking module as input variables

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "vnet_id" {
  description = "ID of the Azure Virtual Network"
  type        = string
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet"
  type        = string
}

variable "worker_node_subnet_id" {
  description = "ID of the worker node subnet"
  type        = string
}
