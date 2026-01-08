########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.7"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Create CBR Zone
##############################################################################

# A network zone with Service reference to schematics
module "cbr_zone" {
  source           = "terraform-ibm-modules/cbr/ibm//modules/cbr-zone-module"
  version          = "1.35.8"
  name             = "${var.prefix}-network-zone"
  zone_description = "CBR Network zone for schematics"
  account_id       = data.ibm_iam_account_settings.iam_account_settings.account_id
  addresses = [{
    type = "serviceRef"
    ref = {
      account_id   = data.ibm_iam_account_settings.iam_account_settings.account_id
      service_name = "schematics"
    }
  }]
}

module "namespace" {
  providers = {
    ibm = ibm.namespace
  }
  source                  = "../.."
  namespace_name          = var.prefix == null ? "namespace" : "${var.prefix}-namespace"
  existing_namespace_name = var.existing_namespace_name
  resource_group_id       = module.resource_group.resource_group_id
  tags                    = var.resource_tags
  access_tags             = var.access_tags
  images_per_repo         = var.images_per_repo
  retain_untagged         = var.retain_untagged
    # CBR rule only allowing the Key Protect instance to be accessbile from Schematics
  cbr_rules = [{
    description      = "${var.prefix}-namespace access only from schematics"
    enforcement_mode = "enabled"
    account_id       = data.ibm_iam_account_settings.iam_account_settings.account_id
    rule_contexts = [{
      attributes = [
        {
          name  = "networkZoneId"
          value = module.cbr_zone.zone_id
        }
      ]
    }]
  }]
}

module "upgrade_plan" {
  source = "../../modules/plan"
}

module "set_quota" {
  source            = "../../modules/quotas"
  storage_megabytes = 5 * 1024 - 1
  traffic_megabytes = 499
  # Issue 324: Upgrade plan before extending quota
  depends_on = [module.upgrade_plan]
}
