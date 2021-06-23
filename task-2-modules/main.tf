// Terraform configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

// Provider
provider "azurerm" {
  features {}
}


// Resource Group
resource "azurerm_resource_group" "t1" {
  name     = "${var.project_name}-task1"
  location = var.location
}


// Virtual machines module
module "vm" {
    source        = "./vm"
    project_name  = var.project_name
    group_name    = azurerm_resource_group.t1.name
    location      = var.location
    vm_size       = var.vm_size
    interface_ids = module.vnet.interface_ids
}

// Virtual network module
module "vnet" {
    source       = "./vnet"
    project_name = var.project_name
    group_name   = azurerm_resource_group.t1.name
    location     = var.location
}