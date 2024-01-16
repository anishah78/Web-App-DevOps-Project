output "aks_cluster_name" {
  description = "Name of the provisioned AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}