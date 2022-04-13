

@minLength(3)
@maxLength(24)
param storageAccountName string

@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
])
param type string = 'Standard_LRS'

var containerName = 'images'

param storageLocation string 



resource stacc 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storageAccountName
  location: storageLocation
  kind: 'StorageV2'
  sku: {
    name: type
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2020-08-01-preview' ={

  name: '${stacc.name}/default/${containerName}'
}

output storageId string = stacc.id
output storage object = stacc
