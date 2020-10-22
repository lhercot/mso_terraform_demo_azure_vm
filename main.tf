terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

data "azurerm_resource_group" "vms" {
  name     = var.vm_resource_group_name
}

data "azurerm_resource_group" "net" {
  name     = var.net_resource_group_name
}

data "azurerm_virtual_network" "net1" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.net.name
}

data "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.net.name
  virtual_network_name = data.azurerm_virtual_network.net1.name
}

resource "azurerm_public_ip" "ip1" {
  name                = "${var.vm_name}-public-ip"
  location            = data.azurerm_resource_group.vms.location
  resource_group_name = data.azurerm_resource_group.vms.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "interface1" {
  name                = "${var.vm_name}-nic"
  location            = data.azurerm_resource_group.vms.location
  resource_group_name = data.azurerm_resource_group.vms.name

  ip_configuration {
    name                          = "${var.vm_name}-internal"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip1.id
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.vms.name
  location            = data.azurerm_resource_group.vms.location
  size                = "Standard_DS1_v2"
  admin_username      = var.vm_user_name
  network_interface_ids = [
    azurerm_network_interface.interface1.id,
  ]

  admin_ssh_key {
    username   = var.vm_user_name
    public_key = var.ssh_pub_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/85ca999d-c9c7-484b-82b8-6854bc1e2af5/resourceGroups/VMs_WoS_WoS-VRF_westus/providers/Microsoft.Compute/images/WoS-wordpress-Image2"

  tags = {
    EPG = "Web"
  }

  custom_data = base64encode(<<EOF
    #cloud-config
    runcmd:
    - "sed -i 's/10.101.0.11/${var.db_ip_address}/g' /etc/hosts"
  EOF
  )
}