resource "azurerm_dev_center_gallery" "example" {
  name              = "example"
  dev_center_id     = var.identity.id
  shared_gallery_id = var.shared_gallery_id
}