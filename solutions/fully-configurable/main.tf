locals {
  endpoints = {
    "ap-north"   = "jp.icr.io"
    "jp-tok"     = "jp.icr.io"
    "ap-south"   = "au.icr.io"
    "au-syd"     = "au.icr.io"
    "us-south"   = "us.icr.io"
    "br-sao"     = "br.icr.io"
    "ca-tor"     = "ca.icr.io"
    "eu-central" = "de.icr.io"
    "eu-es"      = "es.icr.io"
    "jp-osa"     = "jp2.icr.io"
    "uk-south"   = "uk.icr.io"
    "global"     = "icr.io"
  }
}

########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.3.0"
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
  images_per_repo   = var.images_per_repo
  retain_untagged   = var.retain_untagged
}

module "upgrade_plan" {
  count                       = var.upgrade_to_standard_plan ? 1 : 0
  source                      = "../../modules/plan"
  container_registry_endpoint = var.provider_visibility == "private" ? "private.${local.endpoints[var.namespace_region]}" : local.endpoints[var.namespace_region]
}

module "set_quota" {
  source                      = "../../modules/quotas"
  container_registry_endpoint = var.provider_visibility == "private" ? "private.${local.endpoints[var.namespace_region]}" : local.endpoints[var.namespace_region]
  storage_megabytes           = var.storage_megabytes
  traffic_megabytes           = var.traffic_megabytes
}
