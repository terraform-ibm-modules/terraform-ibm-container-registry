########################################################################################################################
# Resource group
########################################################################################################################

locals {
  # Test infrastructure may use us-east, regsitry does not support us-east
  # for this example if us-east is used, place the registry in us-south (us.icr.io)
  registry_region = var.region == "us-east" ? "us-south" : var.region
}

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.0.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

module "namespace" {
  source            = "../.."
  name              = var.name
  resource_group_id = module.resource_group.resource_group_id
  #  ibmcloud_api_key  = var.ibmcloud_api_key
  tags            = var.tags
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged
  registry_region = local.registry_region
}
