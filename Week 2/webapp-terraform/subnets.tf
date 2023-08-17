## Subnets

# Webapp subnet
resource "azurerm_subnet" "webapp_subnet" {
  name                 = "${var.root_name}app-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.webapp_subnet_space
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = ["Microsoft.ServiceBus", "Microsoft.Web"]

  delegation {
    name = "delegation"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
      name = "Microsoft.Web/serverFarms"
    }
  }
}

# Keyvault subnet
resource "azurerm_subnet" "keyvault_subnet" {
  name                 = "${var.root_name}keyvault-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.keyvault_subnet_space
  virtual_network_name = azurerm_virtual_network.vnet.name

  service_endpoints = ["Microsoft.KeyVault"]
}

# DB subnet
resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.root_name}db-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.db_subnet_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# Bastion
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.bastion_subnet_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# vm
resource "azurerm_subnet" "vm_subnet" {
  name                 = "${var.root_name}vm-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.vm_subnet_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}
