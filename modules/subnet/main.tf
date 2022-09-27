resource "azurerm_subnet" "instance" {
  name                                      = var.instance_name
  resource_group_name                       = var.instance_resource_group_name
  virtual_network_name                      = var.instance_virtual_network_name
  address_prefixes                          = var.instance_subnet_address_prefixes
  private_endpoint_network_policies_enabled = true
}

output "name" {
  value = azurerm_subnet.instance.name
}

output "address_prefixes" {
  value = azurerm_subnet.instance.address_prefixes
}

output "subnet_id" {
  value = azurerm_subnet.instance.id
}