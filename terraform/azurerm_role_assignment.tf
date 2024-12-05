resource "azurerm_role_assignment" "current-user" {
  name               = "User ${data.azurerm_client_config.current.client_id} Key Vault Secrets Officer"
  scope              = azurerm_key_vault.default.id
  role_definition_id = "Key Vault Secrets Officer"
  principal_id       = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "dev-center" {
  name               = "User MSI ${azurerm_user_assigned_identity.dev-center.name} Key Vault Secrets User"
  scope              = azurerm_key_vault.default.id
  role_definition_id = "Key Vault Secrets User"
  principal_id       = azurerm_user_assigned_identity.dev-center.principal_id
}

resource "azurerm_role_assignment" "dev-center" {
  name               = "Userm MSI ${azurerm_user_assigned_identity.dev-center.name} Shared Image Gallery Contributor"
  scope              = azurerm_shared_image_gallery.example.id
  role_definition_id = "Contributor"
  principal_id       = azurerm_user_assigned_identity.dev-center.principal_id
}