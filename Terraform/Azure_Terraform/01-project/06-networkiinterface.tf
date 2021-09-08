# Create network interface
resource "azurerm_network_interface" "my-NIC" {
  name                = "myNIC"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.my-RG.name

  ip_configuration {
    name                          = "myNicConfig"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myPublicIP.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}