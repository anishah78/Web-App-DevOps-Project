# Inside the cluster module, create outputs.tf

output "aks_cluster_name" {
  description = "Name of the provisioned AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  description = "ID of the provisioned AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kubeconfig" {
  description = "Kubernetes configuration file for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].raw_kube_config
}
