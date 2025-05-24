##############################################################################
# Common variables
##############################################################################

variable "container_registry_endpoint" {
  type        = string
  description = "The endpoint of the IBM Container Registry, eg. us.icr.io or de.icr.io, to change quotas"
  default     = "us.icr.io"

  validation {
    condition     = can(regex("^(private.)?([a-z]{2}[2]?.)?icr.io$", var.container_registry_endpoint))
    error_message = "registry endpoint must match the regular expression \"^(private.)?([a-z]{2}[2]?.)?icr.io$\", see https://cloud.ibm.com/docs/Registry?topic=Registry-registry_overview#registry_regions_global"
  }
}

variable "storage_megabytes" {
  type        = number
  description = "Storage quota in megabytes. The value -1 denotes `Unlimited`"
  default     = null
}

variable "traffic_megabytes" {
  type        = number
  description = "Traffic quota in megabytes. The value -1 denotes `Unlimited`."
  default     = null
}
