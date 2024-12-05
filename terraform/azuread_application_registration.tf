resource "azuread_application_registration" "packer" {
  display_name     = "Dev Center Packer SPN"
  description      = "An App Registration for Packer to use with Azure Dev Center"
  sign_in_audience = "AzureADMyOrg"

  homepage_url          = "https://devgbb.devcenter.demo/"
}

resource "azuread_service_principal" "packer" {
  client_id    = azuread_application_registration.packer.client_id
  use_existing = true
}

resource "azuread_service_principal_password" "packer" {
  service_principal_id = azuread_service_principal.packer.id
}

resource "azurerm_role_assignment" "packer" {
  description = "Allow Packer to manage resources in the Dev Center Resource Group"
  scope = azurerm_resource_group.default.id
  role_definition_name = "Contributor"
  principal_type = "ServicePrincipal"
  principal_id = azuread_service_principal.packer.object_id
}