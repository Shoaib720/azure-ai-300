terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-mgmt"
    storage_account_name = "stgaccterraformartifacts"
    container_name = "tfstates"
    key = "ml.dev.ephemeral.eastus.tfstate"
  }
}

provider "azurerm" {
  features {}
}