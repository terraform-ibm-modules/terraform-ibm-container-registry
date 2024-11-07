########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  count                        = var.use_existing_namespace == null ? 0 : 1
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ? (var.prefix != null ? "${var.prefix}-${var.resource_group_name}" : var.resource_group_name) : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

module "namespace" {
  providers = {
    ibm = ibm.namespace
  }
  count                  = var.namespace_name == null ? 0 : 1
  source                 = "../.."
  name                   = var.use_existing_namespace || var.prefix == null ? var.namespace_name : "${var.prefix}-${var.namespace_name}"
  use_existing_namespace = var.use_existing_namespace
  resource_group_id      = var.use_existing_namespace ? null : module.resource_group[0].resource_group_id
  tags                   = var.tags
  images_per_repo        = var.images_per_repo
  retain_untagged        = var.retain_untagged
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
