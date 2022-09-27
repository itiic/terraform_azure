resource "tls_private_key" "instance" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_linux_virtual_machine" "instance" {
  name                  = var.instance_name
  location              = var.instance_location
  resource_group_name   = var.instance_resource_group_name
  network_interface_ids = [var.instance_network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Disk1"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = var.instance_computer_name
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.instance.public_key_openssh
  }

}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.instance.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.instance.private_key_pem
  sensitive = true
}
