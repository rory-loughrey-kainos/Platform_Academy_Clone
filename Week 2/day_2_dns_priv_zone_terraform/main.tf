resource "resource_group" "rg_name" {
  prefix = var.resource_group_name_prefix
  name = "rl-dns-priv"
}

resource "azurerm_resource_group" "rg" {
  name     = resource_group.rg_name.id
  location = var.resource_group_location
}

resource "azurerm_dns_zone" "zone" {
  name = (
    var.dns_zone_name != null ?
    var.dns_zone_name : "rl_dns_zone"
  )
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "record" {
  name                = "www"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name           = azurerm_dns_zone.zone.name
  ttl                 = var.dns_ttl
  records             = var.dns_records
}