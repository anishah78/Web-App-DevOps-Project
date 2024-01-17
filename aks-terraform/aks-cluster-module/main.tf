  resource "azurerm_kubernetes_cluster" "example_cluster" {
  name                = "example-aks-cluster"
  location            = "East US"
  resource_group_name = "example-resource-group"
  dns_prefix          = "exampleaks"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  network_profile {
    network_plugin = "azure"
  }

  depends_on = [
    azurerm_resource_group.networking_rg,
  ]
}
