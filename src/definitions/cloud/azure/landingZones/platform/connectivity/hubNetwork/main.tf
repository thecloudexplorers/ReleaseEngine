resource "azurerm_resource_group" "rg" {
  name     = "rg-connectivity"
  location = "uksouth"
}

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  # insert the 3 required variables here

  resource_group_name = "rg-connectivity"
  vnet_location       = "uksouth"
  vnet_name           = "vnet-hub"

  use_for_each = "true"
}
