# Create virtual network
resource "azurerm_virtual_network" "virtaul_network" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.my-RG.name

  tags = {
    environment = "Terraform Demo"
  }
  depends_on = [
    azurerm_resource_group.my-RG
  ]
}

