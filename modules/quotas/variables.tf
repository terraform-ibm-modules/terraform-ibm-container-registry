##############################################################################
# Common variables
##############################################################################

variable "container_registry_endpoint" {
  description = "The endpoint of the ICR region, eg. https://us.icr.io or https://de.icr.io, to change quotas"
  type        = string
  default     = "us.icr.io"
  validation {
    condition     = can(regex("^(private.)?([a-z]{2}[2]?.)?icr.io$", var.container_registry_endpoint))
    error_message = "registry endpoint must match the regular expression \"^(private.)?([a-z]{2}[2]?.)?icr.io$\", see https://cloud.ibm.com/docs/Registry?topic=Registry-registry_overview#registry_regions_global"
  }
}

variable "update_storage_quota" {
  description = "Set to true to update storage quota of the registry."
  type        = bool
  default     = true
}

variable "storage_megabytes" {
  description = "Storage quota in megabytes. The value -1 denotes `Unlimited`"
  type        = number
  default     = 500
}

variable "update_traffic_quota" {
  description = "Set to true to update traffic pull quota of the registry."
  type        = bool
  default     = true
}

variable "traffic_megabytes" {
  description = "Traffic quota in megabytes. The value -1 denotes `Unlimited`."
  type        = number
  default     = 5120
}
