resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_private_dns_zone" "zone" {
  name = "mydomain.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "priv_zone_link" {
  name                = "example-vnet-link"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id  = azurerm_virtual_network.network.id
}

resource "azurerm_virtual_network" "network" {
  name                = "rl-test-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
