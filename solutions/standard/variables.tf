# Common
variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

# Namespace
variable "use_existing_resource_group" {
  type        = bool
  description = "Indicates whether to use an existing resource group. If set to 'false', a new resource group will be created."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where resources will be provisioned. This can either be an existing resource group or a new one."
  default     = "icr-namespace"
}

variable "region" {
  type        = string
  description = "The IBM Cloud region where the container registry namespace and retentation policy will be created."
  default     = "us-south"
}

variable "name" {
  type        = string
  description = "The name of the container registry namespace to be created. If not provided, no namespace will be created."
  default     = null
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
  description = "The endpoint of the ICR region, eg. https://us.icr.io or https://de.icr.io"
  type        = string
  default     = "us.icr.io"
}

variable "upgrade_to_standard_plan" {
  description = "Set true to upgrade to`standard` plan for container registry, this is not reversible"
  type        = bool
  default     = false
}

variable "update_traffic_quota" {
  type        = bool
  description = "Set to 'true' to modify the traffic pull quota for the container registry."
  default     = false
}

variable "update_storage_quota" {
  type        = bool
  description = "Set to 'true' to modify the storage quota for the container registry."
  default     = false
}

variable "storage_megabytes" {
  type        = number
  description = "The storage quota in megabytes for the container registry. Use -1 for unlimited storage."
  default     = 500
}

variable "traffic_megabytes" {
  type        = number
  description = "The traffic pull quota in megabytes for the container registry. Use -1 for unlimited traffic."
  default     = 5120
}
