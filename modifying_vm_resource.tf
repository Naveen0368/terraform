provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name     = "<resource_group_name>"
}

data "azurerm_virtual_machine" "example" {
  name                = "<existing_vm_name>"
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_virtual_machine" "example" {
  name                  = data.azurerm_virtual_machine.example.name
  location              = data.azurerm_virtual_machine.example.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_id  = data.azurerm_virtual_machine.example.network_interface_id
  vm_size               = "<new_vm_size>"

  storage_os_disk {
    name              = data.azurerm_virtual_machine.example.storage_os_disk.name
    caching           = data.azurerm_virtual_machine.example.storage_os_disk.caching
    create_option     = data.azurerm_virtual_machine.example.storage_os_disk.create_option
    managed_disk_type = "<new_managed_disk_type>"
  }

  storage_image_reference {
    id = data.azurerm_virtual_machine.example.storage_image_reference.id
  }

  os_profile {
    computer_name  = data.azurerm_virtual_machine.example.os_profile.computer_name
    admin_username = data.azurerm_virtual_machine.example.os_profile.admin_username
    admin_password = data.azurerm_virtual_machine.example.os_profile.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = data.azurerm_virtual_machine.example.os_profile_linux_config.disable_password_authentication

    ssh_keys {
      path     = data.azurerm_virtual_machine.example.os_profile_linux_config.ssh_keys.0.path
      key_data = data.azurerm_virtual_machine.example.os_profile_linux_config.ssh_keys.0.key_data
    }
  }

  tags = data.azurerm_virtual_machine.example.tags
}
