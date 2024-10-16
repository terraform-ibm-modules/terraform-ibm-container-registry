########################################################################################################################
# Resource group
########################################################################################################################

locals {
  registry_with_standard_plan = [ for registry in var.registry_configuration: registry.icr_endpoint if registry.plan == "Standard"]
}

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ?  var.resource_group_name : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

module "namespace" {
  count = length(var.namespaces)
  source            = "../.."
  name              = var.namespaces[count.index]["name"]
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.namespaces[count.index]["tags"]
  images_per_repo   = var.namespaces[count.index]["name"]["images_per_repo"]
  retain_untagged   = var.namespaces[count.index]["name"]["retain_untagged"]
}

module "upgrade_plan" {
  count = length(local.registry_with_standard_plan)
  source                      = "../..//modules/plan"
  container_registry_endpoint = local.registry_with_standard_plan[count.index]
}

module "set_quota"{
  count = length(var.registry_configuration)
  source = "../../modules/quotas"
  container_registry_endpoint = var.registry_configuration[count.index]["icr_endpoint"]
  storage_megabytes =  var.registry_configuration[count.index]["storage_megabytes"]
  traffic_megabytes =  var.registry_configuration[count.index]["traffic_megabytes"]
}