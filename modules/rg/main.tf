resource "azurerm_resource_group" "instance" {
  name     = var.instance_name
  location = var.instance_location
}

output "name" {
  value = azurerm_resource_group.instance.name
}

output "location" {
  value = azurerm_resource_group.instance.location
}