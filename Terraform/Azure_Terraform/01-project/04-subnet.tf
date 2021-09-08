# Create subnet
resource "azurerm_subnet" "mySubnet" {
  name                 = "myPublicIP"
  resource_group_name  = azurerm_resource_group.my-RG.name
  virtual_network_name = azurerm_virtual_network.virtaul_network.name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [
    azurerm_virtual_network.virtaul_network
  ]
}