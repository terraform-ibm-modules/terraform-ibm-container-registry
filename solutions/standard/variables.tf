########################################################################################################################
# Common variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "existing_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to provision resource in."
  default     = "Default"
  nullable    = false
}

variable "prefix" {
  type        = string
  description = "The prefix to add to all resources that this solution creates (e.g `prod`, `test`, `dev`). To not use any prefix value, you can set this value to `null` or an empty string."
  nullable    = true
  validation {
    condition = (var.prefix == null ? true :
      alltrue([
        can(regex("^[a-z]{0,1}[-a-z0-9]{0,14}[a-z0-9]{0,1}$", var.prefix)),
        length(regexall("^.*--.*", var.prefix)) == 0
      ])
    )
    error_message = "Prefix must begin with a lowercase letter, contain only lowercase letters, numbers, and - characters. Prefixes must end with a lowercase letter or number and be 16 or fewer characters."
  }
}

variable "provider_visibility" {
  type        = string
  description = "Set the visibility value for the IBM terraform provider. Supported values are `public`, `private`, `public-and-private`. [Learn more](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/guides/custom-service-endpoints)"
  default     = "private"
  nullable    = false

  validation {
    condition     = contains(["public", "private", "public-and-private"], var.provider_visibility)
    error_message = "Invalid value for 'provider_visibility'. Allowed values are 'public', 'private', or 'public-and-private'."
  }
}

########################################################################################################################
# Namespace
########################################################################################################################

variable "namespace_region" {
  type        = string
  description = "The IBM Cloud region where the container registry namespace and retention policy will be created or where the existing namespace is located."
}

variable "namespace_name" {
  type        = string
  description = "The name of the container registry namespace to create."
  default     = "namespace"
}

variable "existing_namespace_name" {
  type        = string
  description = "The name of an existing namespace."
  default     = null
}

variable "tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the IBM container namespace."
  default     = []
}

variable "images_per_repo" {
  type        = number
  description = "Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default)"
  default     = 0
}

variable "retain_untagged" {
  type        = bool
  description = "Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs."
  default     = false
}

########################################################################################################################
# Settings
########################################################################################################################

variable "upgrade_to_standard_plan" {
  type        = bool
  description = "Set to true to upgrade container registry to the 'Standard' plan. This action cannot be undone once applied."
  default     = false
}

variable "storage_megabytes" {
  type        = number
  description = "The storage quota in megabytes for the container registry. Use -1 for unlimited storage. If not specified, then the container registry storage quota is not set."
  default     = null
}

variable "traffic_megabytes" {
  type        = number
  description = "The traffic pull quota in megabytes for the container registry. Use -1 for unlimited traffic. If not specified, then the container registry traffic quota is not set."
  default     = null
}
