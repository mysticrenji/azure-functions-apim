## Azure Service Principal Creation
az ad sp create-for-rbac -n "MyApp" --role Contributor --scopes /subscriptions/{SubID}/resourceGroups/{ResourceGroup1} /subscriptions/{SubID}/resourceGroups/{ResourceGroup2} </br>

## Export Service principal credentials from the query above
export AZURE_SUBSCRIPTION_ID=''</br>
export AZURE_TENANT_ID=''</br>
export AZURE_CLIENT_ID=''</br>
export AZURE_CLIENT_SECRET=''</br>

## Create Azure Blob Storage to act as Terraform Backend
Edit the bash blobstoragecreation.sh and update values , then execute </br>

## Execute Terraform script in sequence
1. terraform init
2. terraform plan
3. terraform apply -var="key=value"

You may have to import the resource state if you are reusing the same resource group as that of azure storage account for apim. </br>
In that case, execute the below command </br>
terraform import azurerm_resource_group.resourcegroup /subscriptions/subscriptionid/resourceGroups/rg-experiments-apim</br>

## TF State file on Blob Storage
![Alt text](./BlobStorage.PNG?raw=true "Blob Storage")

