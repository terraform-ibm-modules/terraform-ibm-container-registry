variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "us-south"
}

variable "use_existing_resource_group" {
  type        = bool
  description = "Whether to use an existing resource group."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of a new or existing resource group to provision resources in."
  default = "icr-namespace"
}

variable "registry_configuration" {
  type = list(object({
    icr_endpoint = string
    plan = optional(string, "Free")
    storage_megabytes = optional(number, 500)
    traffic_megabytes = optional(number, 5120)
  }))
  description = "List of container registry configurations, each object represents a registry with optional plan, storage, and traffic limits."
  default = []
}


variable "namespaces" {
  type = list(object({
    name = string
    tags = optional(list(string), [])
    images_per_repo = optional(number, 2)
    retain_untagged = optional(bool, false)
  }))

  description = "List of namespaces configuration for container registries"
  default = []
}