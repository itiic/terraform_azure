variable "kv_name" {
  type = string
}

variable "kv_resource_group_name" {
  type = string
}

variable "instance_name" {
    type = string
}

variable "instance_location" {
  type = string
}

variable "instance_resource_group_name" {
  type = string
}

variable "instance_dns_prefix" {
  type = string
}

variable "instance_node_count" {
    type = number
}

variable "instance_vm_size" {
  type = string
}

variable "instance_node_max_pods" {
    type = number
}

variable "instance_subnet_id" {
    type = string
}

variable "instance_os_disk_size_gb" {
    type = number
}

variable "instance_admin_username" {
    type = string
}
