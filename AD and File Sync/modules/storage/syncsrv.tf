# https://github.com/hashicorp/terraform-provider-azurerm/issues/5299

resource "azurerm_storage_share" "tf-thinh-str-share" {
  name                 = "tf-thinh-str-share"
  storage_account_name = azurerm_storage_account.tf-thinh-stracc-share.name
  quota                = 700
  enabled_protocol = "SMB"
  acl {
    id = "GhostedRecall"
    access_policy {
      permissions = "r"
    }
  }
  depends_on = [ 
    azurerm_storage_account.tf-thinh-stracc-share
  ]
}

resource "azurerm_storage_sync" "tf-thinh-str-sync" {
  name                = "tf-thinh-str-sync"
  resource_group_name = var.name_of_rsg
  location            = var.name_of_location
  incoming_traffic_policy = "AllowAllTraffic"
}

resource "azurerm_storage_sync_group" "tf-thinh-str-syncgrp" {
  name            = "tf-thinh-str-syncgrp"
  storage_sync_id = azurerm_storage_sync.tf-thinh-str-sync.id
}

resource "azurerm_storage_sync_cloud_endpoint" "tf-thinh-str-cloendpoint" {
  # In order to create a endpoint service, you have to set -- account_replication_type = "GRS"
  name                  = "tf-thinh-str-cloendpoint"
  storage_sync_group_id = azurerm_storage_sync_group.tf-thinh-str-syncgrp.id
  file_share_name       = azurerm_storage_share.tf-thinh-str-share.name
  storage_account_id    = azurerm_storage_account.tf-thinh-stracc-share.id
  depends_on = [ 
    azurerm_storage_sync_group.tf-thinh-str-syncgrp,
    azurerm_storage_share.tf-thinh-str-share,
    azurerm_storage_account.tf-thinh-stracc-share
  ]
}