resource "azurerm_dev_center_dev_box_definition" "default" {
  location           = var.resource_group.location
  name               = "default-dcet"
  dev_center_id      = azurerm_dev_center.default.id
  image_reference_id = "${azurerm_dev_center.default.id}/galleries/default/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win10-m365-gen2"
  sku_name           = "general_i_8c32gb256ssd_v2"
}