resourceGroup = {
  name     = "rg-connectivity-spoke"
  location = "uksouth"
  tags = {
    workload = "releaseengine"
  }
}

hubVnet = {
  name            = "vnet-hub"
  resourceGroup   = "rg-connectivity"
  subscription_id = "337ba254-3aa0-4551-ba8e-89debefaa373"
  tenant_id       = "47832e2c-ecb7-4a68-b534-b142a21317f0"

  tags = {
    workload = "releaseengine"
  }
}

spokeVnet = {
  name            = "vnet-spoke"
  address_space   = ["10.1.0.0/16"]
  subnet_names    = ["default"]
  subnet_prefixes = ["10.0.1.0/24"]
  subscription_id = "337ba254-3aa0-4551-ba8e-89debefaa373"
  tenant_id       = "47832e2c-ecb7-4a68-b534-b142a21317f0"

  tags = {
    workload = "releaseengine"
  }
}
