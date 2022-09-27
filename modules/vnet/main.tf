resource "azurerm_virtual_network" "instance" {
  name                = var.instance_name
  location            = var.instance_location
  resource_group_name = var.instance_resource_group_name
  address_space       = var.instance_address_space
}

output "name" {
  value = azurerm_virtual_network.instance.name
}

output "address_space" {
  value = azurerm_virtual_network.instance.address_space
}

