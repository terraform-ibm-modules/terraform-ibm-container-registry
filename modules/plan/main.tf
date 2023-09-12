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
  create_path    = "//${var.container_registry_endpoint}/api/v1/plans"
  destroy_method = "PATCH"
  destroy_path   = "//${var.container_registry_endpoint}/api/v1/plans"
  destroy_data   = "{\"plan\":\"Standard\"}"
  read_method    = "GET"
  read_path      = "//${var.container_registry_endpoint}/api/v1/plans"
  update_method  = "PATCH"
  update_path    = "//${var.container_registry_endpoint}/api/v1/plans"
  id_attribute   = "plan"
}
