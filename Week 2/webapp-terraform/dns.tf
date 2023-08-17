# priv dns
resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "${var.root_name}postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# dns link
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "${var.root_name}dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}