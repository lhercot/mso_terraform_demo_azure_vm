output "public_ip_address" {
  value = azurerm_public_ip.ip1.ip_address
  description = "The public IP address of the VM"
}

output "ip_address" {
  value = azurerm_linux_virtual_machine.vm1.private_ip_address
  description = "The private IP address of the VM"
}

output "user" {
  value = var.vm_user_name
  description = "The name of the user for the VM"
}