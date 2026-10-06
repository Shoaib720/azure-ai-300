data "azurerm_client_config" "current" {}

data "azurerm_machine_learning_workspace" "ml_workspace" {
  name                = var.machine_workspace_name
  resource_group_name = var.global_configs.resource_group_name
}

data "azurerm_subnet" "ml_subnet" {
  name                 = var.network_configs.subnet_name
  virtual_network_name = var.network_configs.virtual_network_name
  resource_group_name  = coalesce(var.network_configs.resource_group_name, var.global_configs.resource_group_name)
}