param appName string
param location string = resourceGroup().location
param storageAccount object
param storageName string
param storageID string
param appInsights object
param hostingPlan string
var functionAppName = 'clapptest0001'
resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    
    httpsOnly: true
    serverFarmId: hostingPlan
    clientAffinityEnabled: true
    siteConfig: {
      appSettings: [
        {
          'name': 'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value': appInsights.properties.InstrumentationKey
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageID, storageAccount.apiVersion).keys[0].value}'
        }
        {
          'name': 'FUNCTIONS_EXTENSION_VERSION'
          'value': '~2'
        }
        {
          'name': 'FUNCTIONS_WORKER_RUNTIME'
          'value': 'node'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageID, storageAccount.apiVersion).keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        // WEBSITE_CONTENTSHARE will also be auto-generated - https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings#website_contentshare
        // WEBSITE_RUN_FROM_PACKAGE will be set to 1 by func azure functionapp publish
      ]
    }
  }
}





