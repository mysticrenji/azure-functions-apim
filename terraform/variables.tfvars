variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-experiments-apim"
}

variable "az-backend" {
  description = "Backend for terraform in Azure"
  default     = "terraformblobstoragedev"
}

variable "location" {
  description = "Location of the resources"
  default     = "Southeast Asia"
}

variable "company" {
  description = "Name of the company"
  default     = "API Factory Ltd"
}

variable "email" {
  description = "Email ID of the company"
  default     = "renjithvr11@gmail.com"
}

variable "apim_name" {
  description = "APIM Name"
  default     = "apim-functions-sea"
}
