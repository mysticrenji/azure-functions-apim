# Configure the Azure provider
provider "azurerm" { 
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~> 4.0"
  features {}
}

#Create the blob storage backend in Azure before running this
#Export access key and store in ARM_ACCESS_KEY
#This block cannot read from tfvars as this is assoicated with a provider
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-experiments-apim"
    storage_account_name  = "terraformblobstoragedev"
    container_name        = "tstate"
    key                   = "terraform.tfstate"
    
  }
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_api_management" "apim-resource" {
  name                = var.apim_name
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  publisher_name      = var.company
  publisher_email     = var.email

  sku_name = "Developer_1"
}

resource "azurerm_api_management_api" "apim-management" {
  name                = "terraform-api"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  api_management_name = azurerm_api_management.apim-resource.name
  revision            = "1"
  display_name        = "API 1"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-json"
    content_value  = file("${path.module}/conference-api.json")
  }
}
