#keyvault
resource "azurerm_key_vault" "vault" {
  name                       = "${var.root_name}keyvault"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  //random password 16 chars 
  network_acls {
    default_action             = "Deny"
    bypass                     = "None"
    virtual_network_subnet_ids = [azurerm_subnet.keyvault_subnet.id]
  }
}