# resource "azurerm_mssql_server" "tf-thinh-sqlsrv" {
#   name                         = "tf-thinh-sqlsrv"
#   resource_group_name          = var.name_of_rsg
#   location                     = var.name_of_location
#   version                      = "12.0"
#   administrator_login          = "thinhphung"
#   administrator_login_password = "123qwe!@#QWE"
#   minimum_tls_version          = "1.2"
# }

# resource "azurerm_mssql_firewall_rule" "tf-thinh-sqlfw-rule-1" {
#   name             = "tf-thinh-sqlfw-rule-1"
#   server_id        = azurerm_mssql_server.tf-thinh-sqlsrv.id
#   start_ip_address = "171.245.204.72"
#   end_ip_address   = "171.245.204.72"
#   depends_on = [ 
#     azurerm_mssql_server.tf-thinh-sqlsrv
#   ]
# }

# resource "azurerm_mssql_firewall_rule" "tf-thinh-sqlfw-rule-2" {
#   name             = "tf-thinh-sqlfw-rule-2"
#   server_id        = azurerm_mssql_server.tf-thinh-sqlsrv.id
#   start_ip_address = "113.161.91.195"
#   end_ip_address   = "113.161.91.195"
#   depends_on = [ 
#     azurerm_mssql_server.tf-thinh-sqlsrv
#   ]
# }

# resource "azurerm_mssql_database" "tf-thinh-sqldb" {
#   name           = "tf-thinh-sqldb"
#   server_id      = azurerm_mssql_server.tf-thinh-sqlsrv.id
#   max_size_gb = 2
#   sku_name = "Basic"
#   geo_backup_enabled = false
#   depends_on = [ 
#     azurerm_mssql_server.tf-thinh-sqlsrv
#   ]
# }