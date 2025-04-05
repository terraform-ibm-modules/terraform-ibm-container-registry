########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.2.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
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
  images_per_repo         = var.images_per_repo
  retain_untagged         = var.retain_untagged
}

module "upgrade_plan" {
  source = "../..//modules/plan"
}

module "set_quota" {
  source            = "../../modules/quotas"
  storage_megabytes = 5 * 1024 - 1
  traffic_megabytes = 499
}
