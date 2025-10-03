##############################################################################
# Common variables
##############################################################################

variable "region" {
  description = "Region used to determine the IBM Cloud Container Registry endpoint"
  type        = string
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key."
  sensitive   = true
}
