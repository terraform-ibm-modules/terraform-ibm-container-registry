##############################################################################
# terraform-ibm-container-registry
#
# Upgrade container registry plan
##############################################################################

# Upgrade container registry plan
action "ibm_cr_plan_upgrade" "standard" {
  config {
    endpoint = var.container_registry_endpoint
  }
}

# Actions have no state. This resource triggers the upgrade on first apply
# and again whenever the endpoint changes.
resource "terraform_data" "plan_upgrade" {
  input = var.container_registry_endpoint

  lifecycle {
    action_trigger {
      events  = [after_create, after_update]
      actions = [action.ibm_cr_plan_upgrade.standard]
    }
  }
}

# Drop the old restapi object from state without calling its destroy.
removed {
  from = restapi_object.container_registry_plan_upgrade
  lifecycle {
    destroy = false
  }
}
