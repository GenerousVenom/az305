module "general_module" {
  source = "./modules/general"
  name_of_location = local.name_of_location
  name_of_rsg = local.name_of_rsg
  name_of_vnet = local.name_of_vnet
  vnet_address_space = local.vnet_address_space
}

# module "bastion_module" {
#   source = "./modules/bastion"
#   name_of_location = local.name_of_location
#   name_of_rsg = local.name_of_rsg
#   name_of_vnet = local.name_of_vnet
#   vnet_address_space = local.vnet_address_space
#   depends_on = [ 
#     module.general_module
#   ]
# }

# module "loganalytic_module" {
#   source = "./modules/loganalytic"
#   name_of_location = local.name_of_location
#   name_of_rsg = local.name_of_rsg
#   depends_on = [ 
#     module.general_module
#   ]
# }

# module "appsrv_module" {
#   source = "./modules/appsrv"
#   name_of_location = local.name_of_location
#   name_of_rsg = local.name_of_rsg
#   depends_on = [ 
#     module.general_module
#   ]
# }

# module "storage_module" {
#   source = "./modules/storage"
#   name_of_location = local.name_of_location
#   name_of_rsg = local.name_of_rsg
#   depends_on = [ 
#     module.general_module
#   ]
# }

module "winwm_module" {
  source = "./modules/winvm"
  name_of_location = local.name_of_location
  name_of_rsg = local.name_of_rsg
  name_of_vnet = local.name_of_vnet
  vnet_address_space = local.vnet_address_space
  depends_on = [ 
    module.general_module
  ]
}