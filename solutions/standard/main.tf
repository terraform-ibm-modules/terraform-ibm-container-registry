########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ? var.resource_group_name : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

module "namespace" {
  count             = var.name == null ? 0 : 1
  source            = "../.."
  name              = var.name
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.tags
  images_per_repo   = var.images_per_repo
  retain_untagged   = var.retain_untagged
}

module "upgrade_plan" {
  count                       = var.upgrade_to_standard_plan ? 1 : 0
  source                      = "../..//modules/plan"
  container_registry_endpoint = var.container_registry_endpoint
}

module "set_quota" {
  source                      = "../../modules/quotas"
  container_registry_endpoint = var.container_registry_endpoint
  update_storage_quota        = var.update_storage_quota
  update_traffic_quota        = var.update_traffic_quota
  storage_megabytes           = var.storage_megabytes
  traffic_megabytes           = var.traffic_megabytes
}
