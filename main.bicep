targetScope = 'subscription'

@description('The location for all resources.')
param location string = deployment().location

@description('The username to use for your resource names.')
param username string // required parameter (userXXX)

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${username}-lab-rg'
  location: location
}

module appServiceModule 'app-service.bicep' = {
  scope: resourceGroup
  name: 'appServiceModule'
  params: {
    location: location
    username: username
  }
}
