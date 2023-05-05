provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name = "hyperv-migration-landingzone-tf"    
        storage_account_name = "thomastfstate"
        container_name = "terraform.tfstate"
    }
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "landingzone" {
        name = "hyperv-lan-migration"
        location = "eastus2"
}

#Create virtual network
resource "azurerm_virtual_network" "landingzonevnet" {
    name                = "landingzone-vnet"
    address_space       = ["192.168.0.0/16"]
    location            = "eastus2"
    resource_group_name = azurerm_resource_group.landingzone.name
}

# Create subnets
# Create GatewaySubnet
resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.0.0/24"
}

# Create AzureFirewallSubnet
resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.1.0/24"
}

# Create DomainControllerSubnet
resource "azurerm_subnet" "DomainControllerSubnet" {
  name                 = "DomainControllerSubnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.2.0/24"
}

# Create smartHotelWAFSubnet
resource "azurerm_subnet" "smartHotelWAFSubnet" {
  name                 = "smartHotelWAFSubnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.3.0/24"
}

# Create smartHotelWeb1Subnet
resource "azurerm_subnet" "smartHotelWeb1Subnet" {
  name                 = "smartHotelWeb1Subnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.4.0/24"
}

# Create smartHotelWeb2Subnet
resource "azurerm_subnet" "smartHotelWeb2Subnet" {
  name                 = "smartHotelWeb2Subnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.5.0/24"
}

# Create smartHotelSQLSubnet
resource "azurerm_subnet" "smartHotelSQLSubnet" {
  name                 = "smartHotelSQLSubnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.6.0/24"
}

# Create smartHotelSQLSubnet
resource "azurerm_subnet" "Server2003Subnet" {
  name                 = "Server2003Subnet"
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzonevnet.name
  address_prefix       = "192.168.7.0/24"
}


#Create Application Security Groups
#Create dcasg
resource "azurerm_application_security_group" "dcasg" {
  name                = "dcasg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

#Create wafasg
resource "azurerm_application_security_group" "wafasg" {
  name                = "wafasg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

#Create web1asg
resource "azurerm_application_security_group" "web1asg" {
  name                = "web1asg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

#Create web2asg
resource "azurerm_application_security_group" "web2asg" {
  name                = "web2asg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

#Create dbasg
resource "azurerm_application_security_group" "dbasg" {
  name                = "dbasg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

# Create network security group and rule
resource "azurerm_network_security_group" "landingzonensg" {
  name                = "landingzone-nsg"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name

  security_rule {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "62.254.63.52"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "testasg"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_application_security_group_ids = [azurerm_application_security_group.dbasg.id]
    destination_address_prefix = "*"
  }
}

# Create Log Analytics workspace 
resource "azurerm_log_analytics_workspace" "landingzoneworkspace" {
  name                = "landingzoneworkspace-01"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


# Create network interface for dc2
resource "azurerm_network_interface" "dc2nic" {
  name                      = "dc2-nic"
  location                  = "eastus2"
  resource_group_name       = azurerm_resource_group.landingzone.name

  ip_configuration {
    name                          = "dc2-niccfg"
    subnet_id                     = azurerm_subnet.DomainControllerSubnet.id
    private_ip_address_allocation = "static"
    private_ip_address           = "192.168.2.4"
  }
}


# Create virtual machine
resource "azurerm_virtual_machine" "dc2" {
  name                  = "dc2"
  location              = azurerm_resource_group.landingzone.location
  resource_group_name   = azurerm_resource_group.landingzone.name
  network_interface_ids = [azurerm_network_interface.dc2nic.id]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "dc2osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "dc2"
    admin_username = "tamops"
    admin_password = "Password123#!"
  }

   os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent = true
  }

}