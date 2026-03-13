terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
 
provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "rg" {
  name     = "rg-finops-testing"
  location = "Central US"
}
 
resource "azurerm_service_plan" "app_plan" {
  name                = "finops-app-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}
 
resource "azurerm_linux_web_app" "app_service" {
  name                = "finops-web-app-myapp"  # Change this!
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id
 
  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
 
  app_settings = {
    "WEBSITES_PORT" = "8080"
  }
}