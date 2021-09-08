resource "azurerm_public_ip" "myPublicIP" {
  name                = "myPublicIP"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.my-RG.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}