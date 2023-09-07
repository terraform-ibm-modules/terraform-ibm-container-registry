##############################################################################
# terraform-ibm-container-registry
#
# Upgrade container registry plan
##############################################################################

# Upgrade container registry plan
resource "restapi_object" "container_registry_plan_upgrade" {
  path           = "//${var.container_registry_endpoint}/api/v1/plans"
  data           = "{\"plan\":\"Standard\"}"
  create_method  = "PATCH"
  read_method    = "GET"
  update_method  = "PATCH"
  destroy_method = "PATCH"
  create_path    = "//${var.container_registry_endpoint}/api/v1/plans"
  read_path      = "//${var.container_registry_endpoint}/api/v1/plans"
  update_path    = "//${var.container_registry_endpoint}/api/v1/plans"
  destroy_path   = "//${var.container_registry_endpoint}/api/v1/plans"
  id_attribute   = "plan"
}
