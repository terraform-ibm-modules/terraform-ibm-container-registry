variable "name" {
  description = "Name of the container registry namespace"
  type        = string
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group"
  default     = "Default"
}

variable "tags" {
  type        = list(string)
  description = "Tags that should be applied to the service"
  default     = null
}

variable "images_per_repo" {
  type        = number
  default     = 2
  description = "Determines how many images will be retained for each repository when the retention policy is executed. The value -1 denotes 'Unlimited' (all images are retained)"
  //description = "Enter 0 if you dont want to apply retention policy. The value -1 denotes 'Unlimited' (all images are retained)"
  validation {
    condition = (
      var.images_per_repo > -1
    )
    error_message = "Number of images to retain must be greater than -1."
  }
}

variable "retain_untagged" {
  type        = bool
  description = "Determines if untagged images are retained when executing the retention policy. This is false by default meaning untagged images will be deleted when the policy is executed."
  default     = false
}