resource "azurerm_network_interface" "instance" {
  name                = var.instance_virtual_network_interface_name
  location            = var.instance_location
  resource_group_name = var.instance_resource_group_name

  ip_configuration {
    private_ip_address_allocation = "Static"
    private_ip_address            = var.instance_private_ip_address
    subnet_id                     = var.instance_subnet_id
    name                          = var.instance_ip_configuration_name
  }
}

output "name" {
  value = azurerm_network_interface.instance.name
}

output "private_ip_address" {
  value = azurerm_network_interface.instance.ip_configuration[0].private_ip_address
}

output "id" {
  value = azurerm_network_interface.instance.id
}
