terraform {
  required_version = ">= 1.9.0"
  required_providers {
    # Use "greater than or equal to" range in modules
    # tflint-ignore: terraform_unused_required_providers
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.79.0, < 2.0.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.20.0, <2.0.0"
    }
  }
}
