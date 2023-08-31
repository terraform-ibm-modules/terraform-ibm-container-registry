variable "name" {
  description = "Name of the container registry namespace"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$", var.name))
    error_message = "container registry namespace name should match regex /^[a-z0-9]+[a-z0-9_-]+[a-z0-9]+$/"
  }
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID where the IBM container namespace will be created."
}

variable "tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the IBM container namespace."
  default     = []
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

variable "retain_untagged" {
  type        = bool
  description = "(Optional, Bool) Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs."
  default     = false
}
