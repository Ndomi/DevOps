resource "azurerm_virtual_machine" "demo-instance-1" {
  location              = var.location
  name                  = "${var.prefix}-vm"
  network_interface_ids = [azurerm_network_interface.demo-instance-1.id]
  resource_group_name   = azurerm_resource_group.demo.name
  vm_size               = "Standard_A1_v2"

  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    name              = "myosdisk1"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = "demo"
    computer_name  = "demo-instance"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/demo/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface" "demo-instance-1" {
  location            = var.location
  name                = "${var.prefix}-instance1"
  resource_group_name = azurerm_resource_group.demo.name
  #  network_security_group_id = azurerm_network_security_group.allow-ssh.id

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demo-instance-1.id
  }
}

resource "azurerm_public_ip" "demo-instance-1" {
  allocation_method   = "Dynamic"
  location            = var.location
  name                = "instance1-public-ip"
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_application_security_group" "demo-instance-group" {
  location            = var.location
  name                = "internet-gacing"
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_network_interface_application_security_group_association" "demo-instance-group" {
  application_security_group_id = azurerm_application_security_group.demo-instance-group.id
  network_interface_id          = azurerm_network_interface.demo-instance-1.id
  #  ip_configuration_name = "instance1"
}

# demo instance 2
resource "azurerm_virtual_machine" "demo-instance-2" {
  location              = var.location
  name                  = "${var.prefix}-vm-2"
  network_interface_ids = [azurerm_network_interface.demo-instance-2.id]
  resource_group_name   = azurerm_resource_group.demo.name
  vm_size               = "Standard_A1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    name              = "myosdisk2"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = "demo"
    computer_name  = "demo-instance"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/demo/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface" "demo-instance-2" {
  location            = var.location
  name                = "${var.prefix}-instance2"
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "instance2"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.demo-internal-1.id
  }
}