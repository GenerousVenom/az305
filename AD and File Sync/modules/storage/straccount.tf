resource "azurerm_storage_account" "tf-thinh-stracc-share" {
  name                     = "tfthinhstrshare"
  resource_group_name      = var.name_of_rsg
  location                 = var.name_of_location
  account_tier             = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "GRS"
}