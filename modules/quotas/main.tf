##############################################################################
# Upgrade container registry quota
##############################################################################

# Upgrade container registry storage quota
resource "restapi_object" "container_registry_storage_quota" {
  count = var.update_storage_quota ? 1 : 0
  path  = "//${var.container_registry_endpoint}/api/v1/quotas"
  data = jsonencode({
    "storage_megabytes" : var.storage_megabytes
  })
  create_method  = "PATCH"
  create_path    = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_method = "PATCH"
  destroy_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_data = jsonencode({
    "storage_megabytes" : 500 # set to default 500 MB
  })
  read_method   = "GET"
  read_path     = "//${var.container_registry_endpoint}/api/v1/quotas"
  update_method = "PATCH"
  update_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  object_id     = "storage"
}

# Upgrade container registry pull traffic quota
resource "restapi_object" "container_registry_traffic_quota" {
  count = var.update_traffic_quota ? 1 : 0
  path  = "//${var.container_registry_endpoint}/api/v1/quotas"
  data = jsonencode({
    "traffic_megabytes" : var.traffic_megabytes
  })
  create_method  = "PATCH"
  create_path    = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_method = "PATCH"
  destroy_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_data = jsonencode({
    "traffic_megabytes" : 5120 # set to default 5GiB
  })
  read_method   = "GET"
  read_path     = "//${var.container_registry_endpoint}/api/v1/quotas"
  update_method = "PATCH"
  update_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  object_id     = "traffic"
}
