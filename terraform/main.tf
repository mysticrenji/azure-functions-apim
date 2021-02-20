provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
}

terraform {
 backend "remote" {
   organization = "terraformblobstorage" #Azure Blobstoragename

   workspaces {
     name = "terraform-dev" # workspace name for terraform seggration
   }
 }
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_api_management" "apim-resource" {
  name                = "${var.apim_name}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  publisher_name      = "${var.company}"
  publisher_email     = "${var.email}"

  sku_name = "Developer_1"
}

resource "azurerm_api_management_api" "apim-management" {
  name                = "example-api"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  api_management_name = azurerm_api_management.resource.name
  revision            = "1"
  display_name        = "API 1"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-json"
    content_value  = file("${path.module}/conference-api.json")
  }
}