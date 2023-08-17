# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.67.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.root_name}rg"
  location = var.location
}

## Networking

# NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.root_name}nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Webapp Vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.root_name}vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}

# private endpoint
resource "azurerm_private_endpoint" "priv_endpoint" {
  name                = "${var.root_name}priv-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = "${var.root_name}priv-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_postgresql_server.db_server.id
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = "${var.root_name}dns-zone-postgres-database-azure-com"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone.id]
  }
}






