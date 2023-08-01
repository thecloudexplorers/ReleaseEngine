resourceGroup = {
  name     = "rg-connectivity"
  location = "uksouth"
  tags = {
    workload = "releaseengine"
  }
}

hubVnet = {
  name = "vnet-hub"
  tags = {
    workload = "releaseengine"
  }
}
