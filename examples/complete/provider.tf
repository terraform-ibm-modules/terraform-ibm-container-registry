########################################################################################################################
# Provider config
########################################################################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

provider "ibm" {
  alias            = "namespace"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.namespace_region
}

# Data source to account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}
