resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks-test" {
  name                = "aks-test"
  resource_group_name = var.resource_group
  location            = var.location
  dns_prefix          = "exampleaks1"

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