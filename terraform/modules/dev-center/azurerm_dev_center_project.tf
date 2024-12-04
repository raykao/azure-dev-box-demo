resource "azurerm_dev_center_project" "default" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  dev_center_id       = var.identity.id
  name                = "${azurerm_dev_center.default.name}-project-1"
}