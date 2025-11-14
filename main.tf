terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.110.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "lab" {
  name     = "rg-lab"
  location = "East US"
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "lab" {
  name                = "aks-lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  dns_prefix          = "labdemo"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.lab.kube_config_raw
  sensitive = true
}
