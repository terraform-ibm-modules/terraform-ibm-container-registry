########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

module "namespace" {
  source            = "../.."
  name              = "${var.prefix}-namespace"
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags
  images_per_repo   = var.images_per_repo
  retain_untagged   = var.retain_untagged
}

module "upgrade_plan" {
  source                      = "../..//modules/plan"
  container_registry_endpoint = "us.icr.io"
}

module "set_quota" {
  source                      = "../../modules/quotas"
  container_registry_endpoint = "br.icr.io"
  storage_megabytes           = 5 * 1024 - 1
  traffic_megabytes           = 499
}
