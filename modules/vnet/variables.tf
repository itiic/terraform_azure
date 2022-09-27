variable "instance_name" {
  type = string
  description = "Name of VNET"
}

variable "instance_location" {
  type = string
  default = "West Europe"
  description = "Location of Resource Group"
}

variable "instance_resource_group_name" {
  type = string
  default = "RG1"
  description = "Name of Resource Group"
}

variable "instance_address_space" {
    type = list(string)
    description = "Address space of the VNET"
}
