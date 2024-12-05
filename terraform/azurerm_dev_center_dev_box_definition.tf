resource "azurerm_dev_center_dev_box_definition" "default" {
  location           = var.resource_group.location
  name               = "default-dcet"
  dev_center_id      = azurerm_dev_center.default.id
  image_reference_id = data.azurerm_shared_image_version.custom_image[jetbrains].id
  sku_name           = "demo"
}