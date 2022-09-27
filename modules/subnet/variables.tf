variable "instance_name" {
  type = string
  description = "Name of Subnet"
}

variable "instance_resource_group_name" {
  type = string
  default = "RG1"
  description = "Name of Resource Group"
}

variable "instance_virtual_network_name" {
  type = string
  description = "Name of VNET"
}

variable "instance_subnet_address_prefixes" {
    type = list(string)
    description = "Address Prefixes"
}
