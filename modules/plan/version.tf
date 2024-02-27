terraform {
  required_version = ">= 1.0.0, <1.7.0"
  required_providers {
    # Use "greater than or equal to" range in modules
    # tflint-ignore: terraform_unused_required_providers
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.49.0, < 2.0.0"
    }
    # tflint-ignore: terraform_unused_required_providers
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.18.2"
    }
  }
}
