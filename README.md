
# Deploying an App Service with bicep

This repository contains one bicep file `app-service.bicep`. This template file contains baisc configuration for an app service plan with one app service and an extra staging slot in a given resource group.

## How to deploy

Use the Azure CLI to create a deployment. Pass the bicep template file and enter the resource group name. The resource group name is used to generate names for its resources.

```bash
az deployment group create --template-file app-service.bicep --resource-group user<XXX>-lab-rg
```