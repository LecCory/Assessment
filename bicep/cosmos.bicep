// param appName string
// var appCosmosName = '${appName}${uniqueString(resourceGroup().id)}'
// param location string = 'canadacentral'

// param autoscaleMaxThroughput int = 4000




// resource symbolicname 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-11-15-preview' = {
//   name: '${appCosmosName}/string'
//   location: location
//   tags: {
//     tagName1: 'tagValue1'
//     tagName2: 'tagValue2'
//   }
  
//   identity: {
//     type: 'None'
//     userAssignedIdentities: {}
//   }
//   properties: {
//     options: {
//       autoscaleSettings: {
//         maxThroughput: autoscaleMaxThroughput
//       }
//       throughput: autoscaleMaxThroughput
//     }
//     resource: {
//       id: 'string'
//     }
//   }
// }
param appName string
var cosmosDBAccountName = '${appName}${uniqueString(resourceGroup().id)}'
param location string = 'canadacentral'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2021-11-15-preview'= {
  name: cosmosDBAccountName
  kind: 'MongoDB'
  location: location
  properties:{

    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority:0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard' 
  }
}



resource mongoDb 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-06-15' = {
  name: '${cosmosDBAccount.name}/assessment'
 
  properties: {
    resource: {

      id: 'assessment'
    }
    options: {}
  }
}
