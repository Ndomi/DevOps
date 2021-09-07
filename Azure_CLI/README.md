# List the VMs
```
az vm list -o table
```

# List Resource Group
```
az group list -o table
```

# Create Resource Group
```
az group create -n RG-04-Azure-CLI -l westeurope
```

# Create a virtual machine in the above Resource Group
```
az vm create \        
--resource-group RG-04-Azure-CLI \
--name UbuntuVM-CLI \
--image UbuntuLTS \
--admin-username adminuser \
--admin-password adminadmin123!
```

# Resize VM
## Check the list of available VM sizes
```
az vm list-vm-resize-options --resource-group RG-04-Azure-CLI --name UbuntuVM-CLI -o table
```

## Resize the Vm with az vm resize
```
az vm resize --resource-group RG-04-Azure-CLI --name UbuntuVM-CLI --size Standard_B1s
```

# Stop the VM
```
az vm stop --resource-group RG-04-AZURE-CLI --name UbuntuVM-CLI
```

# Deallocate a VM(To avoid billing)
```
az vm deallocate --resource-group RG-04-AZURE-CLI --name UbuntuVM-CLI
```

