variable "net_resource_group_name" {
  type = string
  default = "CAPIC_WoS_WoS-VRF_westus"
  description = "The Azure Resource Group name for the VNET"
}

variable "vm_resource_group_name" {
  type = string
  default = "VMs_WoS_WoS-VRF_westus"
  description = "The Azure Resource Group name for the VM"
}

variable "virtual_network_name" {
  type = string
  default = "WoS-VRF"
  description = "The Azure VNET name"
}

variable "subnet_name" {
  type = string
  default = "subnet-10.101.200.128_25"
  description = "The Azure Subnet name"
}

variable "db_ip_address" {
  type = string
  default = "10.101.10.11"
  description = "The IP address of the DB VM to point to"
}

variable "vm_name" {
  type = string
  default = "example"
  description = "The VM name"
}

variable "vm_user_name" {
  type = string
  default = "centos"
  description = "The name of the user for the VM"
}

variable "ssh_pub_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChdMRQ6UFkJ+SLSaHiovC11bSgwCEwe4FMHujrc8Pw5TT7po2Q5Etw9tz0MO4HUd0r1VoQPVlUQCtQfa6Ve+wHhgJTIOAljD5IuyWyAQkOOhxYSLOTg5fvhCV2IAUyTVRXCQ5PMi6VcgWt/BpInNhj8tVBlC8LtDdTLAFeVVIebigdBRHxhi5nFGxT6c94ZhOB32dqZHxQmvgHatyYBsalq1qkX2/Xs5Xwx5KKSsvKp5Ml3X96YRL1nYE6ZPrAVi2TZLUpWMLz6T633HEYhkZIk4tEnOqbX+ACMMbttdwK4FyVumXLSjbfuvEe3TcmHGc0FEXQCC4pj5S79uxBlHUr"
  description = "An SSH key in ssh-rsa string format for the VM user"
}