##############################################################################
# Upgrade container registry quota
##############################################################################

# Upgrade container registry storage quota
resource "restapi_object" "container_registry_storage_quota" {
  count = var.storage_megabytes != null ? 1 : 0
  path  = "//${var.container_registry_endpoint}/api/v1/quotas"
  data = jsonencode({
    "storage_megabytes" : var.storage_megabytes
  })
  id_attribute              = "storage_megabytes"
  ignore_all_server_changes = true
  create_method             = "PATCH"
  create_path               = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_method            = "PATCH"
  destroy_path              = "//${var.container_registry_endpoint}/api/v1/quotas"
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
  count = var.traffic_megabytes != null ? 1 : 0
  path  = "//${var.container_registry_endpoint}/api/v1/quotas"
  data = jsonencode({
    "traffic_megabytes" : var.traffic_megabytes
  })
  id_attribute              = "traffic_megabytes"
  ignore_all_server_changes = true
  create_method             = "PATCH"
  create_path               = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_method            = "PATCH"
  destroy_path              = "//${var.container_registry_endpoint}/api/v1/quotas"
  destroy_data = jsonencode({
    "traffic_megabytes" : 5120 # set to default 5GiB
  })
  read_method   = "GET"
  read_path     = "//${var.container_registry_endpoint}/api/v1/quotas"
  update_method = "PATCH"
  update_path   = "//${var.container_registry_endpoint}/api/v1/quotas"
  object_id     = "traffic"
}
