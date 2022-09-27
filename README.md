# Terraform Azure

Terraform in action

## Access

### App registration

TBD

### IAM role assigment

TBD

### Env variables

```bash
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```

## Terraform

### Install

Based on: [install-cli]([https://](https://learn.hashicorp.com/tutorials/terraform/install-cli))

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring     --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg     --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" |     sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
```

### Init

Init

```bash
$ terraform init
Initializing modules...
- rg_north_europe in ../../modules/rg
- rg_west_europe in ../../modules/rg

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.24.0"...
- Installing hashicorp/azurerm v3.24.0...
- Installed hashicorp/azurerm v3.24.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

### backend

TBD

### create infrastructure

Plan

```bash
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.rg_north_europe.azurerm_resource_group.instance will be created
  + resource "azurerm_resource_group" "instance" {
      + id       = (known after apply)
      + location = "northeurope"
      + name     = "RG2"
    }

  # module.rg_west_europe.azurerm_resource_group.instance will be created
  + resource "azurerm_resource_group" "instance" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "RG1"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + name_north = "RG2"
  + name_west  = "RG1"

```

Apply

```bash
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.rg_north_europe.azurerm_resource_group.instance will be created
  + resource "azurerm_resource_group" "instance" {
      + id       = (known after apply)
      + location = "northeurope"
      + name     = "RG2"
    }

  # module.rg_west_europe.azurerm_resource_group.instance will be created
  + resource "azurerm_resource_group" "instance" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "RG1"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + name_north = "RG2"
  + name_west  = "RG1"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.rg_west_europe.azurerm_resource_group.instance: Creating...
module.rg_north_europe.azurerm_resource_group.instance: Creating...
module.rg_north_europe.azurerm_resource_group.instance: Creation complete after 1s [id=/subscriptions/<ID>/resourceGroups/RG2]
module.rg_west_europe.azurerm_resource_group.instance: Creation complete after 1s [id=/subscriptions/<ID>/resourceGroups/RG1]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

name_north = "RG2"
name_west = "RG1"
```

Check list via CLI

```bash
$ az group list --query "[].name"
[
  "RG1",
  "RG2"
]
```
