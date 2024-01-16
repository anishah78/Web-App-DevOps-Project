esource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster
  location            = var.cluster_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default" #name of default node pool 
    node_count = 1  #initial number of nodes
    vm_size    = "Standard_DS2_v2"  #virtual machine size for the nodes in the pool
    enable_auto_scaling = true  #Enables auto-scaling for the node pool
    min_count = 1 #Sets the minimum number of nodes to 1
    max_count = 3  #Sets the maximum number of nodes to 3
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }
}