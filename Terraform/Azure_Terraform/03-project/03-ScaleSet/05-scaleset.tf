resource "azurerm_virtual_machine_scale_set" "demo" {
  location            = var.location
  name                = "mytestscaleset-1"
  resource_group_name = azurerm_resource_group.demo.name

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent = 20
    max_unhealthy_instance_percent = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.demo.id

  zones = var.zones

  sku {
    capacity = 2
    name     = "Standard_A1_v2"
    tier = "Standard"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  storage_profile_os_disk {
    create_option = "FromImage"
    name = ""
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    create_option = "Empty"
    lun           = 0
    caching = "ReadWrite"
    disk_size_gb = 10
  }

  os_profile {
    admin_username       = "demo"
    computer_name_prefix = "demo"
    custom_data = "#!/bin/bash\n\napt-get update && apt-get install -y nginx && systemctl enable nginx && systemctl start nginx"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/demo/.ssh/authorized_keys"
    }
  }

  network_profile {
    name    = "networkprofile"
    primary = true
    network_security_group_id = azurerm_network_security_group.demo-instance.id

    ip_configuration {
      name      = "IPConfiguration"
      primary   = true
      subnet_id = azurerm_subnet.demo-subnet-1.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }
}