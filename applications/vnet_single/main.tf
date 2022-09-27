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
  source            = "../../modules/rg"
  instance_location = "West Europe"
  instance_name     = "RG1"
}

module "vnet_test1" {
  source                        = "../../modules/vnet"
  instance_name                 = "vnet-1"
  instance_address_space        = [ "10.0.0.0/20" ]
  instance_location             = module.rg_west_europe.location
  instance_resource_group_name  = module.rg_west_europe.name
}
