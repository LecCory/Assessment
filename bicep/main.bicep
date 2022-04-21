
param appName string
param existOrNew bool = true
param storageName string = 'stccory0001'
param location  string = resourceGroup().location


module storageAcct 'storage.bicep' ={
  name: 'storageModule'

  params: {
    storageLocation: location
    storageAccountName: storageName
    
  }
}
module appInsights 'insights.bicep' ={
  name: 'appinsites'
 
  params: {
    appName: appName
    location: location
  }
}

module hostingPlan 'hostingplan.bicep' ={
  name: 'hostingplan'
  
  params: {
    appName: appName
    location: location
  }
}

module azFunction 'azFunction.bicep'  = if (existOrNew){
  dependsOn: [
    storageAcct
    appInsights
    hostingPlan
  ]
  name: 'functionModule'


  params: {
    
    appInsights: appInsights.outputs.appInsights
    // appName: appName
    hostingPlan: hostingPlan.outputs.hostingPlanID
    storageName: storageName
    storageAccount: storageAcct.outputs.storage
    storageID: storageAcct.outputs.storageId
    location: location
    
  }
}

module cosmosDB 'cosmos.bicep' = if(existOrNew){
  name: 'cosmosDB'
  params:{
    location: location
    appName: appName
  }
}
