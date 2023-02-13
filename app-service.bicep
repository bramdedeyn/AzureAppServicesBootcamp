@description('The SKU of App Service Plan')
param sku string = 'S1' // The SKU of App Service Plan

@description('The Docker image to be used')
param linuxFxVersion string = 'DOCKER|unfor19/docker-cats:latest'

@description('The location for all resources.')
param location string = resourceGroup().location

var username = split(resourceGroup().name, '-')[0]
var appServicePlanName = toLower('${username}-plan001')
var webSiteName = toLower('${username}-app001')

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  kind: 'linux'
  sku: {
    name: sku
  }
}

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings: [
        {
          name: 'APP_NAME'
          value: 'baby'
        }, {
          name: 'FROM_AUTHOR'
          value: username
        }, {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io/v1'
        }
      ]
    }
  }
}

resource stagingSlot 'Microsoft.Web/sites/slots@2022-03-01' = {
  name: 'staging'
  parent: appService
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APP_NAME'
          value: 'dark'
        }, {
          name: 'FROM_AUTHOR'
          value: username
        }, {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io/v1'
        }
      ]
    }
  }
}
