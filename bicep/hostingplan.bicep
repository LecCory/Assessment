var hostingPlanName = '${appName}${uniqueString(resourceGroup().id)}'
param appName string
param location string = resourceGroup().location

resource hostingPlan 'Microsoft.Web/serverfarms@2020-10-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: 'Y1' 
    tier: 'Dynamic'
  }
}

output hostingPlanID string = hostingPlan.id



