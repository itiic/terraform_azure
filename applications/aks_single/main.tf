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

module "rg_aks" {
  source            = "../../modules/rg"
  instance_location = "West Europe"
  instance_name     = "RG_AKS"
}

module "kv_aks" {
  source                       = "../../modules/kv"
  instance_name                = "kv1itiicaks"
  instance_sku_name            = "standard"
  instance_location            = module.rg_aks.location
  instance_resource_group_name = module.rg_aks.name
}

module "vnet_aks" {
  source                       = "../../modules/vnet"
  instance_name                = "vnet-aks-1"
  instance_address_space       = ["10.0.0.0/20"]
  instance_location            = module.rg_aks.location
  instance_resource_group_name = module.rg_aks.name
}

module "subnet_aks1" {
  source                           = "../../modules/subnet"
  instance_name                    = "${module.vnet_aks.name}-subnet-test1"
  instance_subnet_address_prefixes = ["10.0.0.0/24"]
  instance_virtual_network_name    = module.vnet_aks.name
  instance_resource_group_name     = module.rg_aks.name
}

module "aks1" {
  source                        = "../../modules/aks"
  kv_name                       = module.kv_aks.name
  kv_resource_group_name        = module.rg_aks.name
  instance_name                 = "aks1"
  instance_location             = module.rg_aks.location
  instance_resource_group_name  = module.rg_aks.name
  instance_dns_prefix           = "aks1"
  instance_node_count           = 2
  instance_vm_size              = "Standard_D2_v2"
  instance_node_max_pods        = 100
  instance_subnet_id            = module.subnet_aks1.subnet_id
  instance_os_disk_size_gb      = 50
  instance_admin_username       = "adminaks"
  depends_on = [
    module.rg_aks,
    module.kv_aks,
    module.vnet_aks,
    module.subnet_aks1
  ]
}
