module "dev-center" {
  source = "./modules/dev-center"
  resource_group = azurerm_resource_group.default
  identity = azurerm_user_assigned_identity.dev-center
  shared_gallery_id = azurerm_dev_center_gallery.example.id
  key_vault_id = azurerm_key_vault.default.id
  subnet-id = azurerm_subnet.dev-center.id
}