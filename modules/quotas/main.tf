##############################################################################
# terraform-ibm-container-registry
#
# Upgrade container registry quota
##############################################################################

# Upgrade container registry quota
resource "restapi_object" "container_registry_quota" {
  path           = "//${var.container_registry_endpoint}/api/v1/quotas"
  data           = jsonencode({
    "storage_megabytes": var.storage_megabytes,
    "traffic_megabytes": var.traffic_megabytes
  })
  create_method  = "PATCH"
  create_path    = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_method = "PATCH"
  destroy_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_data   = jsonencode({
    "storage_megabytes": 500, # set to default 0.5 GB
    "traffic_megabytes": 5120 # set to default 5GiB
  })
  read_method    = "GET"
  read_path      = "//${var.container_registry_endpoint}/api/v1/quotas"
  update_method  = "PATCH"
  update_path    = "//${var.container_registry_endpoint}/api/v1/quotas"
  object_id = "quotas"
}


