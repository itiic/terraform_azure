variable "instance_name" {
  type = string
  description = "Name of Resource"
}

variable "instance_location" {
  type = string
  default = "West Europe"
  description = "Location of Resource Group"
}

variable "instance_resource_group_name" {
  type = string
}

variable "instance_computer_name" {
  type = string
}


variable "instance_network_interface_id" {
  type = string
}
