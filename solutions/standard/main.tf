########################################################################################################################
# Resource group
########################################################################################################################

# Data source to retrieve token details
data "ibm_iam_auth_token" "token_data" {
}

# Data source to account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ? (var.prefix != null ? "${var.prefix}-${var.resource_group_name}" : var.resource_group_name) : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

module "namespace" {
  count             = var.namespace_name == null ? 0 : 1
  source            = "../.."
  name              = var.prefix != null ? "${var.prefix}-${var.namespace_name}" : var.namespace_name
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.tags
  images_per_repo   = var.images_per_repo
  retain_untagged   = var.retain_untagged
}

module "upgrade_plan" {
  count                       = var.upgrade_to_standard_plan ? 1 : 0
  source                      = "../../modules/plan"
  container_registry_endpoint = var.container_registry_endpoint
}

module "set_quota" {
  source                      = "../../modules/quotas"
  container_registry_endpoint = var.container_registry_endpoint
  storage_megabytes           = var.storage_megabytes
  traffic_megabytes           = var.traffic_megabytes
}
