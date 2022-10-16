
data "azurerm_key_vault" "support" {
  name                  = var.kv_name
  resource_group_name   = var.kv_resource_group_name
}

resource "tls_private_key" "instance" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "ssh_priv" {
  name         = "ssh-priv"
  value        = tls_private_key.instance.private_key_openssh
  key_vault_id = data.azurerm_key_vault.support.id
}

resource "azurerm_key_vault_secret" "ssh_pub" {
  name         = "ssh-pub"
  value        = tls_private_key.instance.public_key_openssh
  key_vault_id = data.azurerm_key_vault.support.id
}

resource "azurerm_kubernetes_cluster" "instance" {
  name                = var.instance_name
  location            = var.instance_location
  resource_group_name = var.instance_resource_group_name
  dns_prefix          = var.instance_dns_prefix

  default_node_pool {
    name            = "default"
    node_count      = var.instance_node_count
    vm_size         = var.instance_vm_size
    max_pods        = var.instance_node_max_pods
    os_disk_size_gb = var.instance_os_disk_size_gb
    vnet_subnet_id  = var.instance_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = "172.11.0.0/24"
    dns_service_ip     = "172.11.0.100"
    docker_bridge_cidr = "172.10.0.1/16"
  }

  linux_profile {
    admin_username = var.instance_admin_username
    ssh_key {
      key_data = azurerm_key_vault_secret.ssh_pub.value
    }
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.instance.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.instance.kube_config_raw
  sensitive = true
}

output "ssh_priv" {
  value = azurerm_key_vault_secret.ssh_priv.value
  sensitive = true
}