# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.11.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hubVnet.subscription_id
  tenant_id       = var.hubVnet.tenant_id

  features {}
}

provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.spokeVnet.subscription_id
  tenant_id       = var.spokeVnet.tenant_id

  features {}
}
# https://github.com/claranet/terraform-azurerm-vnet-peering/blob/master/resources.tf
