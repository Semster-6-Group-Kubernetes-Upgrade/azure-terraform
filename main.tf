terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "aks-test" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks-test-cluster" {
  name                = "aks-test-cluster"
  resource_group_name = azurerm_resource_group.aks-test.name
  location            = var.location

  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}