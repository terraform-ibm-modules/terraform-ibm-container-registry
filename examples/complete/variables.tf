variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "test-icr"
}

variable "region" {
  type        = string
  description = "The IBM Cloud region where the container registry namespace and retentation policy will be created."
  default     = "us-south"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Tags that should be applied to the namespace"
  default     = ["test-icr-tag", "test-icr"]
}

variable "images_per_repo" {
  type        = number
  default     = 2
  description = "Determines how many images will be retained for each repository when the retention policy is executed."
}

variable "retain_untagged" {
  type        = bool
  description = "Determines if untagged images are retained when executing the retention policy."
  default     = false
}
