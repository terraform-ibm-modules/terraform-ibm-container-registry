########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.3.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

resource "ibm_cr_namespace" "cr_namespace" {
  name              = "${var.prefix}-ns"
  resource_group_id = module.resource_group.resource_group_id
}
