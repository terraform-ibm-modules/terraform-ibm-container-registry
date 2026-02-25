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

variable "namespace_region" {
  type        = string
  description = "The IBM Cloud region where the container registry namespace and retention policy will be created or where the existing namespace is located."
  default     = "us-south"
}

variable "existing_namespace_name" {
  type        = string
  description = "The name of an existing namespace. Required if `namespace_name` is not provided."
  default     = null
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Add user resource tags to the Container Registry instance to organize, track, and manage costs. [Learn more](https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#tag-types)."
  default     = ["test-icr-tag", "test-icr"]
}

variable "access_tags" {
  type        = list(string)
  description = "Add access management tags to the Container Registry instance to control access. [Learn more](https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#create-access-console)."
  default     = []
}

variable "images_per_repo" {
  type        = number
  description = "Determines how many images will be retained for each repository when the retention policy is executed."
  default     = 2
}

variable "retain_untagged" {
  type        = bool
  description = "Determines if untagged images are retained when executing the retention policy."
  default     = false
}
