resource "azurerm_resource_group" "my-RG" {
  name = "my-RG"
  location = "westeurope"

  tags = {
      environment = "Terraform Demo"
  }
}