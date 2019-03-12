#####################################################################
##
##      Created 3/12/19 by wiggles@ca.ibm.com. for project1
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  version = "~> 1.1"
}


resource "azurerm_virtual_machine" "simple-vm" {
  name                  = "${var.simple-vm_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.group-jpw.name}"
  tags {
    Name = "${var.simple-vm_name}"
  }
  os_profile {
    computer_name  = "${var.simple-vm_os_profile_name}"
    admin_username = "${var.simple-vm_azure_user}"
    admin_password = "${var.simple-vm_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.simple-vm_publisher}"
    offer     = "${var.simple-vm_offer}"
    sku       = "${var.simple-vm_sku}"
    version   = "${var.simple-vm_version}"
  }
  os_profile_linux_config {
    disable_password_authentication = "${var.simple-vm_disable_password_authentication}"
  }
  storage_os_disk {
    name              = "${var.simple-vm_os_disk_name}"
    caching           = "${var.simple-vm_os_disk_caching}"
    create_option     = "${var.simple-vm_os_disk_create_option}"
    managed_disk_type = "${var.simple-vm_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.simple-vm_os_disk_delete}"
}

resource "azurerm_resource_group" "group-jpw" {
  name     = "group-jpw"
  location = "${var.location}"
}