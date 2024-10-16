terraform {
  required_version = ">= 1.3.0"
  # If your module requires any terraform providers, uncomment the "required_providers" section below and add all required providers.
  # Each required provider's version should be a flexible range to future proof the module's usage with upcoming minor and patch versions.

  required_providers {
    # Pin to the lowest provider version of the range defined in the main module to ensure lowest version still works
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.49.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.18.2"
    }
  }
}
