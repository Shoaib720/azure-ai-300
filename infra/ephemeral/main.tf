locals {
    tags = {
        role = "workload"
        project = "ai-300"
    }
}


resource "azurerm_machine_learning_compute_instance" "ml_compute_instance" {
  name                          = "ml-ci-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  machine_learning_workspace_id = data.azurerm_machine_learning_workspace.ml_workspace.id
  virtual_machine_size          = var.virtual_machine_size
  authorization_type            = "personal"
  node_public_ip_enabled = true
  assign_to_user {
    object_id = var.aad_user_object_id
    tenant_id = data.azurerm_client_config.current.tenant_id
  }
  subnet_resource_id = data.azurerm_subnet.ml_subnet.id
  tags = local.tags
}