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
  source                       = "../../modules/vnet"
  instance_name                = "vnet-1"
  instance_address_space       = ["10.0.0.0/20"]
  instance_location            = module.rg_west_europe.location
  instance_resource_group_name = module.rg_west_europe.name
}

module "subnet_test1" {
  source                           = "../../modules/subnet"
  instance_name                    = "${module.vnet_test1.name}-subnet-test1"
  instance_subnet_address_prefixes = ["10.0.0.0/24"]
  instance_virtual_network_name    = module.vnet_test1.name
  instance_resource_group_name     = module.rg_west_europe.name
}

module "nic_test1" {
  source                                  = "../../modules/nic"
  instance_virtual_network_interface_name = "${module.vnet_test1.name}-nic-test1"
  instance_location                       = module.rg_west_europe.location
  instance_resource_group_name            = module.rg_west_europe.name
  instance_private_ip_address             = "10.0.0.4"
  instance_subnet_id                      = module.subnet_test1.subnet_id
  instance_ip_configuration_name          = "configuration_name"
}
