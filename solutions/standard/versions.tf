terraform {
  required_version = ">= 1.3.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.72.2"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.20.0"
    }
  }
}
