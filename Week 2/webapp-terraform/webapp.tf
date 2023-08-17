## Webapp

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                      = "${var.root_name}webapp"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  service_plan_id           = azurerm_service_plan.appserviceplan.id
  virtual_network_subnet_id = azurerm_subnet.webapp_subnet.id
  site_config {
    minimum_tls_version = "1.2"
    application_stack {
      node_version = "14-lts"
    }
    vnet_route_all_enabled = true
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = var.code_repo
  branch                 = "main"
  use_mercurial          = false
  use_manual_integration = true
}

## App service plan

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.root_name}app-service"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}