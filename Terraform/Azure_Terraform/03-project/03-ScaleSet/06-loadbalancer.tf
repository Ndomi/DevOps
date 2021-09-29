resource "azurerm_lb" "demo" {
  location            = var.location
  name                = "demo-loadbalancer"
  resource_group_name = azurerm_resource_group.demo.name
  sku = length(var.zones) == 0 ? "Basic" : "Standard" # Basic is free, but doesn't support Availability Zones

  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.demo.id
  }
}

resource "azurerm_public_ip" "demo" {
  allocation_method   = "Static"
  location            = var.location
  name                = "demo-public-ip"
  resource_group_name = azurerm_resource_group.demo.name
  sku = length(var.zones) == 0 ? "Basic" : "Standard"
}
resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.demo.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port_end              = 50119
  frontend_port_start            = 50000
  loadbalancer_id                = azurerm_lb.demo.id
  name                           = "ssh"
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.demo.name
}

resource "azurerm_lb_probe" "demo" {
  loadbalancer_id     = azurerm_lb.demo.id
  name                = "http-probe"
  port                = 80
  resource_group_name = azurerm_resource_group.demo.name
  request_path = "/"
  protocol = "Http"
}

resource "azurerm_lb_rule" "demo" {
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port                  = 80
  loadbalancer_id                = azurerm_lb.demo.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.demo.name
  probe_id = azurerm_lb_probe.demo.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id
}