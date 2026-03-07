########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.4.8"
  existing_resource_group_name = var.existing_resource_group_name
}

module "namespace" {
  providers = {
    ibm = ibm.namespace
  }
  count             = var.existing_namespace_name != null ? 0 : 1
  source            = "../.."
  namespace_name    = (var.prefix != null && var.prefix != "") ? "${var.prefix}-${var.namespace_name}" : var.namespace_name
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.tags
  access_tags       = var.access_tags
  images_per_repo   = var.images_per_repo
  retain_untagged   = var.retain_untagged
}

module "cr_endpoint" {
  source = "../../modules/endpoint"
  region = var.namespace_region
}

module "upgrade_plan" {
  count                       = var.upgrade_to_standard_plan ? 1 : 0
  source                      = "../../modules/plan"
  container_registry_endpoint = var.provider_visibility == "private" ? module.cr_endpoint.container_registry_endpoint_private : module.cr_endpoint.container_registry_endpoint
}

module "set_quota" {
  source                      = "../../modules/quotas"
  container_registry_endpoint = var.provider_visibility == "private" ? module.cr_endpoint.container_registry_endpoint_private : module.cr_endpoint.container_registry_endpoint
  storage_megabytes           = var.storage_megabytes
  traffic_megabytes           = var.traffic_megabytes
  # Issue 324: Upgrade plan before setting quota
  depends_on = [module.upgrade_plan]
}
