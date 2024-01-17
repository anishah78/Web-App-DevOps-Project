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

#variables passed into variable.tf in networking-module to be used to create resources

module "aks_cluster" {
  source = "./aks-cluster-module"

  # Input variables for the AKS cluster module
  aks_cluster_name           = "terraform-aks-cluster"
  cluster_location           = "UK South"
  dns_prefix                 = "anishah-project"
  kubernetes_version         = "1.26.6"  # Adjust the version as needed
  service_principal_client_id = "" # Enter your Client ID
  service_principal_client_secret = "" # Enter your password for your client ID

  # Input variables referencing outputs from the networking module
  resource_group_name         = module.networking.network_resource_group_name
  vnet_id                     = module.networking.vnet_id
  control_plane_subnet_id     = module.networking.control_plane_subnet_id
  worker_node_subnet_id       = module.networking.worker_node_subnet_id
  aks_nsg_id                  = module.networking.aks_nsg_id

}

# Declared azure storage account 
resource "azurerm_virtual_network" "aks_vnet" {
  name           = "my_devops_vnet"
  address_space  = var.vnet_address_space
  location   = azurerm_resource_group.networking.location
  resource_group_name  = azurerm_resource_group.example
  depends_on = [azurerm_resource_group.example]
} 

# Defining the Azure Storage Account resource
resource "azurerm_storage_account" "example" {
  name                     = "azurerm_storage_account"
  resource_group_name      = "my-resource-group"
  location                 = "UK South"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [azurerm_resource_group.example]
}

# Essential networking resources for an AKS cluster

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
  name                = "aks_security_group"
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