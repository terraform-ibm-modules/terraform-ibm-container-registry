########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.7"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

#######################################################################################################################
# Creating VPC to show how it can access container registry namespace through CBR rules
#######################################################################################################################

resource "ibm_is_vpc" "example_vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = module.resource_group.resource_group_id
  tags           = var.resource_tags
}

resource "ibm_is_subnet" "testacc_subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.example_vpc.id
  zone                     = "${var.namespace_region}-1"
  total_ipv4_address_count = 256
  resource_group           = module.resource_group.resource_group_id
}



##############################################################################
# Create CBR Zone
##############################################################################

# A network zone with services reference to toolchain service, schematics service and a VPC reference
module "cbr_zone" {
  source           = "terraform-ibm-modules/cbr/ibm//modules/cbr-zone-module"
  version          = "1.35.13"
  name             = "${var.prefix}-network-zone"
  zone_description = "CBR Network zone for allowing access to selected services"
  account_id       = data.ibm_iam_account_settings.iam_account_settings.account_id
  addresses = [
    {
      type  = "vpc", # to bind a specific vpc to the zone
      value = resource.ibm_is_vpc.example_vpc.crn,
    },
    {
      type = "serviceRef"
      ref = {
        account_id   = data.ibm_iam_account_settings.iam_account_settings.account_id
        service_name = "toolchain"
      }
    },
    {
      type = "serviceRef"
      ref = {
        account_id   = data.ibm_iam_account_settings.iam_account_settings.account_id
        service_name = "schematics"
      }
    }
  ]
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
  access_tags             = var.access_tags
  images_per_repo         = var.images_per_repo
  retain_untagged         = var.retain_untagged
  # CBR rule only allowing the namespace to be accessible from toolchain service, schematics service and clusters in the created VPC
  cbr_rules = [{
    description      = "${var.prefix}-namespace access only from toolchain service, schematics service and clusters in the created VPC"
    enforcement_mode = "report" # Use report mode to test access without blocking traffic. Each request generates an Activity Tracker event indicating whether it would be allowed or denied according to the rules. These events can be monitored for a few days to ensure there are no access issues. After validation, change enforcement_mode to enabled to block unintended traffic.
    account_id       = data.ibm_iam_account_settings.iam_account_settings.account_id
    rule_contexts = [{
      attributes = [
        {
          name  = "networkZoneId"
          value = module.cbr_zone.zone_id
        }
      ]
    }]
  }]
}

module "upgrade_plan" {
  source = "../../modules/plan"
}

module "set_quota" {
  source            = "../../modules/quotas"
  storage_megabytes = 5 * 1024 - 1
  traffic_megabytes = 499
  # Issue 324: Upgrade plan before extending quota
  depends_on = [module.upgrade_plan]
}
