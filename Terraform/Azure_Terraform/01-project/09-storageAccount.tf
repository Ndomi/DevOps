# Generate random text for to the network interface
resource "random_id" "randomID" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.my-RG.name
  }
  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my-storage-account" {
  name                     = "diag${random_id.randomID.hex}"
  resource_group_name      = azurerm_resource_group.my-RG.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}