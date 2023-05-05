az account set --subscription 27f048cd-d37e-4655-8fbe-2e41b14d7327

#Create Resource Group
Az group create -l eastus2 -n hyperv-migration-landingzone-tf

#Example output
#{
#    "id": "/subscriptions/27f048cd-d37e-4655-8fbe-2e41b14d7327/resourceGroups/hyperv-migration-landingzone-tf",
#    "location": "eastus2",
#    "managedBy": null,
#    "name": "hyperv-migration-landingzone-tf",
#    "properties": {
#      "provisioningState": "Succeeded"
#    },
#    "tags": null,
#    "type": "Microsoft.Resources/resourceGroups"
#  }
  

#Create Service Principal 
Az ad sp create-for-rbac -n hyperv-migration-landingzone-tf --role contributor --scopes /subscriptions/27f048cd-d37e-4655-8fbe-2e41b14d7327/resourceGroups/hyperv-migration-landingzone-tf

#Example output
# {
#    "appId": "c3bfc8da-c254-4eda-957a-eac3ea498074",
#    "displayName": "hyperv-migration-landingzone-tf",
#    "name": "http://hyperv-migration-landingzone-tf",
#    "password": "Gr8WwhqGg#VsfC7U_!6=1M{eE+hvU,9>",
#    "tenant": "ad669477-9b62-40fa-95a4-52c404ed5bfd"
#  }


#Create Storage Account to store Terraform State file
az storage account create --resource-group hyperv-migration-landingzone-tf --name thomastfstate --sku Standard_LRS --encryption-services blob

#Get Storage account key
az storage account keys list --resource-group hyperv-migration-landingzone-tf --account-name thomastfstate

#Create Storage Account Container
az storage container create --name thomastfstatecontainer --account-name thomastfstate --account-key "op27CuDyTy5eubmwXJRujIfWCsVHp/vOjLdxPO9KqTGFI/facCItMOaDlLbsuJYkNyzHQULIOQJO2h+icBucYg=="

# Register timeinsights
Get-AzResourceProvider -ListAvailable

Register-AzResourceProvider -ProviderNamespace Microsoft.TimeSeriesInsights

Get-AzResourceProvider -ProviderNamespace Microsoft.TimeSeriesInsights