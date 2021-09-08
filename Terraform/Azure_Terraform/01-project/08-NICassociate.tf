# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "my-SG-association" {
  network_interface_id      = azurerm_network_interface.my-NIC.id
  network_security_group_id = azurerm_network_security_group.my-SG.id
}