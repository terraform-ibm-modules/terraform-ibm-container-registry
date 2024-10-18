##############################################################################
# Common variables
##############################################################################

variable "container_registry_endpoint" {
  description = "The endpoint of the ICR region, eg. https://us.icr.io or https://de.icr.io, to change to standard plan"
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

# ap-north jp.icr.io	private.jp.icr.io
# ap-south	au.icr.io	private.au.icr.io
# br-sao	br.icr.io	private.br.icr.io
# ca-tor	ca.icr.io	private.ca.icr.io
# eu-central	de.icr.io	private.de.icr.io
# jp-osa	jp2.icr.io	private.jp2.icr.io
# uk-south	uk.icr.io	private.uk.icr.io
# us-south	us.icr.io private.us.icr.io
# global	icr.io	private.icr.io

# pattern match (possilby "private.") (possibly two letters, a number 2 and a period) "icr.io" with no prefix or suffix
# This avoids very specific checks and allows for new regions to be added without updating the module.
