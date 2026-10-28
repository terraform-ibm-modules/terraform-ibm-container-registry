terraform {
  required_version = ">= 1.14.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "2.9.0"
    }
    # Only needed to remove the old restapi objects from state. Remove in the next release.
    restapi = {
      source  = "Mastercard/restapi"
      version = "2.0.1"
    }
  }
}
