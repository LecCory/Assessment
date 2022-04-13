param location string = 'canadacentral'


targetScope = 'subscription'
resource azresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rgcoryleclair002'
  location: location
  
}

module storageAcct 'storage.bicep' ={
  name: 'storageModule'
  scope: azresourcegroup
  params: {
    location: azresourcegroup.location
  }
}

module azFunction 'azFunction.bicep' ={
  name: 'functionModule'
  scope: azresourcegroup
  params: {
    location: azresourcegroup.location
  }
}

