variable "existing_namespace_name" {
  type        = string
  description = "The name of an existing namespace. Required if 'namespace_name' is not provided."
  default     = null

  # existing_namespace_name can be NULL. If not NULL then at least one namespace should match in existing_cr_namespaces list that matches existing_namespace_name
  validation {
    condition     = var.existing_namespace_name == null || length([for namespace in data.ibm_cr_namespaces.existing_cr_namespaces.namespaces : namespace if namespace.name == var.existing_namespace_name]) > 0
    error_message = "Existing namespace not found in the region"
  }
}

variable "namespace_name" {
  type        = string
  description = "Name of the container registry namespace, if var.existing_namespace_name is not inputted, a new namespace will be created in a region set by provider."

  # namespace_name must matches a specific pattern i.e. it should start and end with lowercase letter or number and can contain underscores and hyphens.
  validation {
    condition     = can(regex("^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$", var.namespace_name))
    error_message = "container registry namespace name should match regex /^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$/"
  }

  # namespace_name must have length between 4 and 30 characters.
  validation {
    condition     = (length(var.namespace_name) >= 4 && length(var.namespace_name) <= 30)
    error_message = "namespace name must contain from 4 to 30 characters "
  }

  # if namespace_name is null, the existing_namespace_name must not be null, and vice versa
  validation {
    condition     = var.namespace_name != null || var.existing_namespace_name != null
    error_message = "When 'namespace_name' is null, a value must be passed for 'var.existing_namespace_name'."
  }
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID where the IBM container namespace will be created."
}

# In addition to locally managed tags on
variable "tags" {
  type        = list(string)
  description = "Optional list of user tags to be added to the IBM container namespace."
  default     = []
}

variable "access_tags" {
  type        = list(string)
  description = "Optional list of access management tags to be added to the IBM container namespace."
  default     = []
}

variable "images_per_repo" {
  type        = number
  description = "(Optional, Integer) Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default)"
  default     = 0

  validation {
    condition = (
      var.images_per_repo >= -1
    )
    error_message = "Number of images to retain must be greater than -1."
  }
}

variable "retain_untagged" {
  type        = bool
  description = "(Optional, Bool) Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs."
  default     = false
}
