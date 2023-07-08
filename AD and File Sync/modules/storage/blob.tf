# resource "azurerm_storage_container" "tf-thinh-str-con" {
#   name                  = "tf-thinh-str-con"
#   storage_account_name  = azurerm_storage_account.tf-thinh-stracc-share.name
#   container_access_type = "container"
# }

# resource "azurerm_storage_blob" "tf-thinh-blob-204" {
#   count = length(local.name)
#   name                   = local.name[count.index]
#   storage_account_name   = azurerm_storage_account.tf-thinh-stracc-share.name
#   storage_container_name = azurerm_storage_container.tf-thinh-str-con.name
#   type                   = "Block"
#   source                 = local.source[count.index]
#   depends_on = [ 
#     azurerm_storage_account.tf-thinh-stracc-share,
#     azurerm_storage_container.tf-thinh-str-con
#   ]
# }