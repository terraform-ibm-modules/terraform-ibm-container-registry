# Common
variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "The prefix to add to all resources that this solution creates."
  default     = null
}

variable "provider_visibility" {
  description = "Set the visibility value for the IBM terraform provider. Supported values are `public`, `private`, `public-and-private`. [Learn more](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/guides/custom-service-endpoints)"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private", "public-and-private"], var.provider_visibility)
    error_message = "Invalid visibility option. Allowed values are 'public', 'private', or 'public-and-private'."
  }
}

variable "use_existing_resource_group" {
  type        = bool
  description = "Indicates whether to use an existing resource group. If set to 'false', a new resource group will be created."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of a new or an existing resource group to provision the container registry namespace in. If a value is passed for the prefix input variable, the prefix value is added to the name in the format of <prefix>-<name>. To use an existing group, set use_existing_resource_group to true."
  default     = "icr-namespace"
}

# Namespace
variable "namespace_region" {
  type        = string
  description = "The IBM Cloud region where the container registry namespace and retention policy will be created or where the existing namespace is located."
  default     = "us-south"
}

variable "namespace_name" {
  type        = string
  description = "The name of the container registry namespace to create or the name of an existing namespace. To configure an existing namespace, set `use_existing_namespace` to true"
  default     = null
}

variable "use_existing_namespace" {
  type        = bool
  description = "Specify true to use an existing container registry namespace in the region defined by `namespace_region`; set false to create a new namespace."
  default     = false
}

variable "tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the IBM container namespace."
  default     = []
}

variable "images_per_repo" {
  type        = number
  default     = 0
  description = "Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default)"
}
variable "retain_untagged" {
  type        = bool
  description = "Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs."
  default     = false
}

# Settings
variable "container_registry_endpoint" {
  description = "The endpoint of the ICR region (e.g., `us.icr.io` or `de.icr.io`) used to set plan and traffic quotas."
  type        = string
  default     = "us.icr.io"
}

variable "upgrade_to_standard_plan" {
  description = "Set to true to upgrade container registry to the 'Standard' plan. This action cannot be undone once applied."
  type        = bool
  default     = false
}

variable "storage_megabytes" {
  type        = number
  description = "The storage quota in megabytes for the container registry. Use -1 for unlimited storage."
  default     = null
}

variable "traffic_megabytes" {
  type        = number
  description = "The traffic pull quota in megabytes for the container registry. Use -1 for unlimited traffic."
  default     = null
}