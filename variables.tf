variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key, only required for registry plan upgrade"
  default     = null
  sensitive   = true
}

variable "images_per_repo" {
  type        = number
  default     = 0
  description = "(Optional, Integer) Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default)"
  validation {
    condition = (
      var.images_per_repo >= -1
    )
    error_message = "Number of images to retain must be greater than -1."
  }
}

variable "name" {
  description = "Name of the container registry namespace"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$", var.name))
    error_message = "container registry namespace name should match regex /^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$/"
  }
}

variable "registry_plan_upgrade" {
  type        = bool
  description = "(Optional, Bool) Determines whether the accounts IBM Container Registry plan is upgrade to standard."
  default     = false
}

variable "registry_region" {
  description = "Registry region"
  type        = string
  validation {
    condition     = contains(["eu-de", "eu-gb", "eu-central", "uk-south", "br-sao", "ca-tor", "us-south", "jp-tok", "jp-osa", "au-syd", "global"], var.registry_region)
    error_message = "Valid registry regions are listed at https://cloud.ibm.com/docs/Registry?topic=Registry-registry_overview#registry_regions_local"
  }
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID where the IBM container namespace will be created."
}

variable "retain_untagged" {
  type        = bool
  description = "(Optional, Bool) Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs."
  default     = false
}

variable "tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the IBM container namespace."
  default     = null
}
