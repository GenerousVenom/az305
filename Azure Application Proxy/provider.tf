terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "Your subscription ID"
  tenant_id       = "Your tenant ID"
  client_id       = "Your client ID"
  client_secret   = "Your client secrect"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true       # * For keyvault.tf file
    }
  }


  # skip_provider_registration = "true"
  # features {
  #   key_vault {
  #     purge_soft_delete_on_destroy = true
  #   }
  # }
}
