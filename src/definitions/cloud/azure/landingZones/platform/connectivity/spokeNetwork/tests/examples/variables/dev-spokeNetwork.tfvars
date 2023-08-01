resourceGroup = {
  name     = "rg-connectivity-spoke"
  location = "uksouth"
  tags = {
    workload = "releaseengine"
  }
}

hubVnet = {
  name          = "vnet-hub"
  resourceGroup = "rg-connectivity"
  tags = {
    workload = "releaseengine"
  }
}

spokeVnet = {
  name            = "vnet-spoke"
  address_space   = ["10.1.0.0/16"]
  subnet_names    = ["default"]
  subnet_prefixes = ["10.0.1.0/24"]

  tags = {
    workload = "releaseengine"
  }
}
