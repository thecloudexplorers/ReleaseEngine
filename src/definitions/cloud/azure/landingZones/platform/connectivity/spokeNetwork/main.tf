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
  vnet_name           = var.spokeVnet.name

  use_for_each = "true"

  subnet_names    = var.spokeVnet.subnet_names
  subnet_prefixes = var.spokeVnet.subnet_prefixes

  tags = var.spokeVnet.tags
}

data "azurerm_virtual_network" "hubVnet" {
  name                = var.hubVnet.name
  resource_group_name = var.hubVnet.resourceGroup
}

# Creates VNET peerings from Hub vNet to Spoke vNet and also from Spoke vNet to Hub vNet
module "vnetpeering" {
  source               = "Azure/vnetpeering/azurerm"
  vnet_peering_names   = ["vnetpeering1", "vnetpeering2"]
  vnet_names           = ["${module.vnet.vnet_name}", "${data.hubVnet.vnet_name}"]
  resource_group_names = ["${var.resourceGroup.name}", "${var.hubVnet.resourceGroup}"]

  tags = var.spokeVnet.tags
}
