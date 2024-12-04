resource "azurerm_dev_center" "default" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  name                = "${var.resource_group.name}-dev-center"
}