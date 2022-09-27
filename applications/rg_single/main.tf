terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.24.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg_west_europe" {
  source        = "../../modules/rg"
  instance_location = "West Europe"
  instance_name = "RG1"
}

module "rg_north_europe" {
  source        = "../../modules/rg"
  instance_location = "North Europe"
  instance_name = "RG2"
}

output "name_west" {
  value = module.rg_west_europe.name
}

output "name_north" {
  value = module.rg_north_europe.name
}

