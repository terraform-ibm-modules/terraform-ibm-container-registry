##############################################################################
# Common variables
##############################################################################

variable "region" {
  description = "Region used to determine the IBM Cloud Container Registry endpoint. Supported regions are listed in the IBM Cloud Registry Overview: https://cloud.ibm.com/docs/Registry?topic=Registry-registry_overview#registry_regions"
  type        = string

  validation {
    condition     = contains(keys(local.endpoints), var.region)
    error_message = "Invalid region. Must be one of: ${join(", ", keys(local.endpoints))}"
  }
}
