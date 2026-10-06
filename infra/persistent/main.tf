locals {
    tags = {
        role = "workload"
        project = "ai-300"
    }
}

resource "azurerm_resource_group" "ml_rg" {
  name     = var.global_configs.resource_group_name
  location = var.global_configs.location
  tags = local.tags
}

resource "azurerm_application_insights" "ml_insights" {
  name                = "appinsight-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  location            = var.global_configs.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  application_type    = "web"
  tags = local.tags
}

resource "azurerm_key_vault" "ml_kv" {
  name                       = "kv-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  location                   = var.global_configs.location
  resource_group_name        = azurerm_resource_group.ml_rg.name
  rbac_authorization_enabled = false
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  tags = local.tags
}

resource "azurerm_storage_account" "ml_stgacc" {
  name                     = "stgacc${lower(var.global_configs.project)}${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  location                 = var.global_configs.location
  resource_group_name      = azurerm_resource_group.ml_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = local.tags
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = "mlworkspace-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  location                = var.global_configs.location
  resource_group_name     = azurerm_resource_group.ml_rg.name
  application_insights_id = azurerm_application_insights.ml_insights.id
  key_vault_id            = azurerm_key_vault.ml_kv.id
  storage_account_id      = azurerm_storage_account.ml_stgacc.id

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_virtual_network" "ml_vnet" {
  name                = "ml-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  address_space       = ["10.0.1.0/24"]
  location            = var.global_configs.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  tags = local.tags
}

resource "azurerm_subnet" "ml_subnet" {
  name                 = "mlsnet-${lower(var.global_configs.project)}-${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  resource_group_name  = azurerm_resource_group.ml_rg.name
  virtual_network_name = azurerm_virtual_network.ml_vnet.name
  address_prefixes     = ["10.0.1.0/25"]
}

resource "azurerm_storage_account" "ml_datastore_stgacc" {
  name                     = "amldatastore${lower(var.global_configs.environment)}${var.global_configs.suffix}"
  location                 = var.global_configs.location
  resource_group_name      = azurerm_resource_group.ml_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = local.tags
}

resource "azurerm_storage_container" "aml_raw_datasets_container" {
  name                  = "raw"
  storage_account_id = azurerm_storage_account.ml_datastore_stgacc.id
  container_access_type = "private"
}

resource "azurerm_machine_learning_datastore_blobstorage" "ds_raw_blob" {
  name                 = "aml_ds_raw"
  workspace_id         = azurerm_machine_learning_workspace.ml_workspace.id
  storage_container_id = azurerm_storage_container.aml_raw_datasets_container.id
  account_key          = azurerm_storage_account.ml_datastore_stgacc.primary_access_key
  is_default = true
}