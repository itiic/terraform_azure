variable "instance_virtual_network_interface_name" {
  type = string
}

variable "instance_location" {
  type = string
}

variable "instance_resource_group_name" {
  type = string
}

variable "instance_private_ip_address" {
  type = string
}

variable "instance_ip_configuration_name" {
  type = string
  default = "default"
}

variable "instance_subnet_id" {
  type = string
}

