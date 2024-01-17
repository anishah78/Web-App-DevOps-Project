terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0" 
        }
    }
}
# defined azure provider 
provider "azurerm" {
    features {}
  client_id       = "66cd9882-ab20-47ac-bd58-e077cdcd37c0"
  client_secret   = "_aW8Q~YtSrXXk5RZK2E-vBrkKmFuFVbvmXFN.bHn"
  subscription_id = "69974029-8ad2-4473-b2e5-a1fb53a6ad13"
  tenant_id       = "47d4542c-f112-47f4-92c7-a838d8a5e8ef"
}

module "networking" {
  source = "./networking-module"

  # Input variables for the networking module
  resource_group_name = "networking-rg" # Creating the resource group name
  location           = "UK South" # Location of the Cluster
  vnet_address_space = ["10.0.0.0/16"] # The address space specifies the range of IP addresses that can be used within the virtual network.

}

module "aks_cluster" {
  source = "./aks-cluster-module"

  # Input variables for the AKS cluster module
  aks_cluster_name           = "terraform-aks-cluster"
  cluster_location           = "UK South"
  dns_prefix                 = "anishah-project"
  kubernetes_version         = "1.26.6"  # Adjust the version as needed
  service_principal_client_id = "66cd9882-ab20-47ac-bd58-e077cdcd37c0"
  service_principal_client_secret = "_aW8Q~YtSrXXk5RZK2E-vBrkKmFuFVbvmXFN.bHn"

  # Input variables referencing outputs from the networking module
  resource_group_name         = module.networking.resource_group_name
  vnet_id                     = module.networking.vnet_id
  control_plane_subnet_id     = module.networking.control_plane_subnet_id
  worker_node_subnet_id       = module.networking.worker_node_subnet_id
}