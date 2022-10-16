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

module "rg_kv_west_europe" {
  source            = "../../modules/rg"
  instance_location = "West Europe"
  instance_name     = "RG_KV"
}

module "kv1" {
  source                       = "../../modules/kv"
  instance_name                = "kv1itiic"
  instance_sku_name            = "standard"
  instance_location            = module.rg_kv_west_europe.location
  instance_resource_group_name = module.rg_kv_west_europe.name
}
