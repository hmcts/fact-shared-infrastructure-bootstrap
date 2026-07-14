locals {
  prefix              = "${var.product}-bstrap-${var.env}"
  resource_group_name = "${local.prefix}-rg"
  key_vault_name      = "${local.prefix}-kv"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.common_tags
}

data "azurerm_user_assigned_identity" "jenkins" {
  name                = "jenkins-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
}

module "key_vault" {
  source                       = "git@github.com:hmcts/cnp-module-key-vault?ref=DTSPO-31965/remove-jenkins-ptl-access"
  name                         = local.key_vault_name
  product                      = var.product
  env                          = var.env
  object_id                    = var.jenkins_AAD_objectId
  jenkins_object_id            = data.azurerm_user_assigned_identity.jenkins.principal_id
  resource_group_name          = azurerm_resource_group.rg.name
  product_group_name           = "DTS FaCT"
  common_tags                  = var.common_tags
  grant_preview_jenkins_access = var.env == "aat"
}