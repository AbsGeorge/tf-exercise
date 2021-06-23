// Public VM
resource "azurerm_linux_virtual_machine" "public"{
  name                = "${var.project_name}-vm"
  resource_group_name = var.group_name
  location            = var.location
  size                = var.vm_size
  network_interface_ids = [var.interface_ids["public"]]
  admin_username      = "absgeorge"


  admin_ssh_key {
    username   = "absgeorge"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
        caching              = "ReadWrite"
        storage_account_type = var.storage_size
    }

  

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

}


// Private VM

resource "azurerm_linux_virtual_machine" "private"{
  name                = "${var.project_name}-vm2"
  resource_group_name = var.group_name
  location            = var.location
  size                = var.vm_size
  network_interface_ids = [var.interface_ids["private"]]


  admin_username      = "absgeorge"
  admin_password      = "testing1"

 

  os_disk {
        caching              = "ReadWrite"
        storage_account_type = var.storage_size
    }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

}
