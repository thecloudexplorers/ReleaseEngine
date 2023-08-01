resourceGroup = {
  name     = "rg-connectivity"
  location = "uksouth"
  tags = {
    workload = "releaseengine"
  }
}

hubVnet = {
  name            = "vnet-hub"
  address_space   = ["10.0.0.0/16"]
  subnet_names    = ["default", "GatewaySubnet"]
  subnet_prefixes = ["10.0.1.0/24", "10.0.2.0/27"]

  tags = {
    workload = "releaseengine"
  }
}

