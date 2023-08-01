resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroup.name
  location = var.resourceGroup.location
  tags     = var.resourceGroup.tags
}

module "spokeVnet" {
  depends_on = [azurerm_resource_group.rg]
  source     = "Azure/vnet/azurerm"
  version    = "4.1.0"
  # insert the 3 required variables here

  resource_group_name = var.resourceGroup.name
  vnet_location       = var.resourceGroup.location
  vnet_name           = var.spokeVnet.name
  address_space       = var.spokeVnet.address_space

  use_for_each = "true"

  subnet_names    = var.spokeVnet.subnet_names
  subnet_prefixes = var.spokeVnet.subnet_prefixes

  tags = var.spokeVnet.tags
}

data "azurerm_virtual_network" "hubVnet" {
  name                = var.hubVnet.name
  resource_group_name = var.hubVnet.resourceGroup
}

# # Creates VNET peerings from Hub vNet to Spoke vNet and also from Spoke vNet to Hub vNet
# module "vnetpeering" {
#   source               = "Azure/vnetpeering/azurerm"
#   vnet_peering_names   = ["vnetpeering1", "vnetpeering2"]
#   vnet_names           = [module.vnet.vnet_name, data.hubVnet.vnet_name]
#   resource_group_names = [var.resourceGroup.name, var.hubVnet.resourceGroup]

#   tags = var.spokeVnet.tags
# }

module "azure_vnet_peering" {
  source = "claranet/vnet-peering/azurerm"
  # version = "5.1.0"

  providers = {
    azurerm.src = azurerm.hub
    azurerm.dst = azurerm.spoke
  }

  vnet_src_id  = module.spokeVnet.vnet_id
  vnet_dest_id = data.azurerm_virtual_network.hubVnet.id

  allow_forwarded_src_traffic  = true
  allow_forwarded_dest_traffic = true

  allow_virtual_src_network_access  = true
  allow_virtual_dest_network_access = true
}
