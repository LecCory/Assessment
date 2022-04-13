param location string = 'canadacentral'

@minLength(3)
@maxLength(24)
param name string = 'sacoryleclair002'

@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
])
param type string = 'Standard_GRS'

var containerName = 'images'


resource stacc 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: type
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2020-08-01-preview' ={
  name: '${stacc.name}/default/${containerName}'
}

output storageId string = stacc.id
