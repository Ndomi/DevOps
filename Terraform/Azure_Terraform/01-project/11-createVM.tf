# Create virtual machine
resource "azurerm_linux_virtual_machine" "my-Vm" {
  name = "myVM"
  location = "westeurope"
  resource_group_name = azurerm_resource_group.my-RG.name
  network_interface_ids = [azurerm_network_interface.my-NIC.id]
  size = "Standard_B1ls"

  os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  computer_name = "My-VM"
  admin_username = "ndomi"
  disable_password_authentication = true

  admin_ssh_key {
    username = "ndomi"
    public_key = tls_private_key.my-SSH-key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my-storage-account.primary_blob_endpoint
  }

  tags = {
      environment = "Terraform Demo"
  }
}