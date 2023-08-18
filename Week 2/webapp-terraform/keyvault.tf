#keyvault
resource "azurerm_key_vault" "vault" {
  name                       = "${var.root_name}keyvault"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  //enable_rbac_authorization  = true
  //random password 16 chars 

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Restore",
      "Backup",
      "Purge"
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "None"
    virtual_network_subnet_ids = [azurerm_subnet.keyvault_subnet.id]
    //ip_rules = ["165.225.197.141"]
  }
}

