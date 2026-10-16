##############################################################################
# Upgrade container registry quota
##############################################################################

# Only the quotas that are set are managed. Destroy resets them to the
# service defaults (500 MB storage, 5120 MB traffic).
resource "ibm_cr_quota" "quota" {
  count             = var.storage_megabytes != null || var.traffic_megabytes != null ? 1 : 0
  endpoint          = var.container_registry_endpoint
  storage_megabytes = var.storage_megabytes
  traffic_megabytes = var.traffic_megabytes
}

# Drop the old restapi objects from state without calling their destroy,
# otherwise the quotas could be reset to the defaults during the upgrade.
removed {
  from = restapi_object.container_registry_storage_quota
  lifecycle {
    destroy = false
  }
}

removed {
  from = restapi_object.container_registry_traffic_quota
  lifecycle {
    destroy = false
  }
}
