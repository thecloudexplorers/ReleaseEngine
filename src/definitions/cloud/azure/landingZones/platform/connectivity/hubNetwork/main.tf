resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroup.name
  location = var.resourceGroup.location
  tags     = var.resourceGroup.tags
}

module "vnet" {
  depends_on = [azurerm_resource_group.rg]
  source     = "Azure/vnet/azurerm"
  version    = "4.1.0"
  # insert the 3 required variables here

  resource_group_name = var.resourceGroup.name
  vnet_location       = var.resourceGroup.location
  vnet_name           = var.hubVnet.name

  use_for_each = "true"

  subnet_names    = var.hubVnet.subnet_names
  subnet_prefixes = var.hubVnet.subnet_prefixes

  tags = var.hubVnet.tags
}
