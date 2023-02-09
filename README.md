
# Deploying an App Service with bicep

This repository contains two bicep files:

* `app-service.bicep`: A config for an app service plan, with a container app service and an extra staging slot.
* `main.bicep`: This deploys a resource group and uses the app service module above to deploy the resources in that resource group.

## How to deploy

Use the Azure CLI to create a deployment and pass `main.bicep` as the template file. The deployment location and a username need to be entered as well. The username is used to generate names for the resource group and its resources.

```bash
az deployment sub create --template-file main.bicep --location westeurope  # and pass username via stdin, or:
az deployment sub create --template-file main.bicep --location westeurope --parameter username=userXXX
```