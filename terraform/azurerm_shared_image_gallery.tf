resource "azurerm_shared_image_gallery" "example" {
  name                = "dev-center-shared-image-gallery"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create shared image definitions for each image
resource "azurerm_shared_image" "image_definitions" {
  for_each            = var.custom_images
  name                = each.key
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  os_type = "Windows"

  trusted_launch_enabled = true
  hyper_v_generation     = "V2"

  identifier {
    publisher = each.value.publisher_name
    offer     = each.value.offer_name
    sku       = each.value.sku
  }
}



resource "terraform_data" "packer" {
  for_each = var.custom_images
  input = each.value

  provisioner "local-exec" {
    working_dir = "../packer-for-image-generation/${each.key}"
    command = <<EOT
      packer init 
      
      packer build \
      -var client_id=${azuread_service_principal.packer.client_id} \
      -var client_secret=${azuread_service_principal_password.packer.value} \
      -var subscription=${var.subscription_id} \
      -var tenant_id=${data.azurerm_client_config.current.tenant_id} \
      -var location=${var.location} \
      -var resource_group=${azurerm_resource_group.example.name} \
      -var image_name=${each.key} \
      -var gallery_resource_group=${azurerm_resource_group.example.name} \
      -var gallery_name=${azurerm_shared_image_gallery.example.name} \
      -var publisher=${each.value.publisher_name} \
      -var offer=${each.value.offer_name} \
      -var image_version=${each.value.semver}  \
      .
    EOT
  }
}

data "azurerm_shared_image_version" "custom_images" {
  depends_on = [ terraform_data.packer ]
  for_each = var.custom_images
  image_name = each.value.image_name
  name = each.value.semver
  gallery_name = azurerm_shared_image_gallery.default.name
  resource_group_name = azurerm_resource_group.default.name
}